from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session

from database import engine, SessionLocal
from models import Usuario, Trabajador
from sqlalchemy import text
from schemas import (
    UsuarioCrear,
    UsuarioRespuesta,
    TrabajadorCrear,
    TrabajadorRespuesta,
    LoginDatos
)

from fastapi.middleware.cors import CORSMiddleware
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def obtener_db():
    db = SessionLocal()

    try:
        yield db
    finally:
        db.close()


@app.get("/")
def inicio():
    return {"mensaje": "API de OfiMatch funcionando"}


@app.get("/test-db")
def test_db():
    try:
        with engine.connect():
            return {"mensaje": "Conexión a PostgreSQL exitosa"}
    except Exception as e:
        return {"error": str(e)}


@app.get("/trabajadores", response_model=list[TrabajadorRespuesta])
def obtener_trabajadores(db: Session = Depends(obtener_db)):
    trabajadores = db.query(Trabajador).all()
    return trabajadores

@app.get("/trabajadores/detalle")
def obtener_trabajadores_detalle(db: Session = Depends(obtener_db)):
    resultado = db.execute(
        text("""
            SELECT
                t.id,
                u.nombre,
                u.apellido,
                c.nombre AS categoria,
                t.categoria_personalizada,
                t.biografia,
                t.ciudad,
                t.disponible
            FROM trabajadores t
            JOIN usuarios u ON u.id = t.usuario_id
            LEFT JOIN categorias c ON c.id = t.categoria_id
            ORDER BY t.id
        """)
    )

    trabajadores = []

    for fila in resultado:
        categoria = fila.categoria or "Sin categoría"

        if categoria == "Otro" and fila.categoria_personalizada:
            categoria = fila.categoria_personalizada

        trabajadores.append({
            "id": fila.id,
            "nombre": f"{fila.nombre} {fila.apellido}",
            "categoria": categoria,
            "ciudad": fila.ciudad,
            "descripcion": fila.biografia,
            "disponible": fila.disponible
        })

    return trabajadores



@app.get("/trabajadores/{trabajador_id}")
def obtener_trabajador(trabajador_id: int, db: Session = Depends(obtener_db)):

    trabajador = db.query(Trabajador).filter(
        Trabajador.id == trabajador_id
    ).first()

    if trabajador is None:
        raise HTTPException(
            status_code=404,
            detail="Trabajador no encontrado"
        )

    usuario = db.query(Usuario).filter(
        Usuario.id == trabajador.usuario_id
    ).first()

    categoria = db.execute(
        text("""
            SELECT nombre
            FROM categorias
            WHERE id = :categoria_id
        """),
        {"categoria_id": trabajador.categoria_id}
    ).fetchone()

    nombre_categoria = categoria.nombre if categoria else "Sin categoría"

    if nombre_categoria == "Otro" and trabajador.categoria_personalizada:
        nombre_categoria = trabajador.categoria_personalizada

    return {
    "id": trabajador.id,
    "usuario_id": trabajador.usuario_id,
    "nombre_publico": trabajador.nombre_publico,
    "nombre": f"{usuario.nombre} {usuario.apellido}",
    "categoria": nombre_categoria,
    "telefono": usuario.telefono,
    "biografia": trabajador.biografia,
    "ciudad": trabajador.ciudad,
    "disponible": trabajador.disponible
}


@app.post("/trabajadores", response_model=TrabajadorRespuesta)
def crear_trabajador(
    trabajador: TrabajadorCrear,
    db: Session = Depends(obtener_db)
):
    nuevo_trabajador = Trabajador(
        usuario_id=trabajador.usuario_id,
        categoria_id=trabajador.categoria_id,
        nombre_publico=trabajador.nombre_publico,
        biografia=trabajador.biografia,
        ciudad=trabajador.ciudad,
        disponible=trabajador.disponible
    )

    db.add(nuevo_trabajador)
    db.commit()
    db.refresh(nuevo_trabajador)

    return nuevo_trabajador
@app.put("/trabajadores/{trabajador_id}", response_model=TrabajadorRespuesta)
def actualizar_trabajador(
    trabajador_id: int,
    datos: TrabajadorCrear,
    db: Session = Depends(obtener_db)
):
    trabajador = db.query(Trabajador).filter(
        Trabajador.id == trabajador_id
    ).first()

    if trabajador is None:
        raise HTTPException(
            status_code=404,
            detail="Trabajador no encontrado"
        )

    trabajador.usuario_id = datos.usuario_id
    trabajador.categoria_id = datos.categoria_id
    trabajador.nombre_publico = datos.nombre_publico
    trabajador.biografia = datos.biografia
    trabajador.ciudad = datos.ciudad
    trabajador.disponible = datos.disponible

    db.commit()
    db.refresh(trabajador)

    return trabajador


@app.delete("/trabajadores/{trabajador_id}")
def eliminar_trabajador(
    trabajador_id: int,
    db: Session = Depends(obtener_db)
):
    trabajador = db.query(Trabajador).filter(
        Trabajador.id == trabajador_id
    ).first()

    if trabajador is None:
        raise HTTPException(
            status_code=404,
            detail="Trabajador no encontrado"
        )

    db.delete(trabajador)
    db.commit()

    return {
        "mensaje": "Trabajador eliminado correctamente"
    }
@app.post("/usuarios", response_model=UsuarioRespuesta)
def crear_usuario(usuario: UsuarioCrear, db: Session = Depends(obtener_db)):

    usuario_existente = db.query(Usuario).filter(
        Usuario.email == usuario.email
    ).first()

    if usuario_existente:
        raise HTTPException(
            status_code=400,
            detail="El correo ya está registrado"
        )

    nuevo_usuario = Usuario(
        nombre=usuario.nombre,
        apellido=usuario.apellido,
        email=usuario.email,
        password=usuario.password,
        telefono=usuario.telefono,
        tipo_usuario=usuario.tipo_usuario
    )

    db.add(nuevo_usuario)
    db.commit()
    db.refresh(nuevo_usuario)

    if usuario.tipo_usuario == "trabajador":

        nuevo_trabajador = Trabajador(
            usuario_id=nuevo_usuario.id,
            categoria_id=usuario.categoria_id,
            categoria_personalizada=usuario.categoria_personalizada,
            nombre_publico=f"{usuario.nombre} {usuario.apellido}",
            biografia="",
            ciudad="Santiago",
            disponible=True
        )

        db.add(nuevo_trabajador)
        db.commit()

    return nuevo_usuario

@app.post("/login")
def login(datos: LoginDatos, db: Session = Depends(obtener_db)):

    usuario = db.query(Usuario).filter(
        Usuario.email == datos.email
    ).first()

    if usuario is None:
        raise HTTPException(
            status_code=401,
            detail="Correo o contraseña incorrectos"
        )

    if usuario.password != datos.password:
        raise HTTPException(
            status_code=401,
            detail="Correo o contraseña incorrectos"
        )

    return {
        "mensaje": "Inicio de sesión correcto",
        "usuario_id": usuario.id,
        "nombre": usuario.nombre,
        "tipo_usuario": usuario.tipo_usuario
    }

@app.get("/admin/estadisticas")
def obtener_estadisticas(db: Session = Depends(obtener_db)):

    total_usuarios = db.query(Usuario).count()

    total_trabajadores = db.query(Usuario).filter(
        Usuario.tipo_usuario == "trabajador"
    ).count()

    total_clientes = db.query(Usuario).filter(
        Usuario.tipo_usuario == "cliente"
    ).count()

    return {
        "usuarios": total_usuarios,
        "trabajadores": total_trabajadores,
        "clientes": total_clientes,
        "reservas": 0
    }
@app.get("/categorias")
def obtener_categorias(db: Session = Depends(obtener_db)):

    resultado = db.execute(
        text("SELECT id, nombre FROM categorias ORDER BY id")
    )

    categorias = []

    for fila in resultado:
        categorias.append({
            "id": fila.id,
            "nombre": fila.nombre
        })

    return categorias

@app.get("/trabajadores/usuario/{usuario_id}")
def obtener_trabajador_por_usuario(
    usuario_id: int,
    db: Session = Depends(obtener_db)
):

    trabajador = db.query(Trabajador).filter(
        Trabajador.usuario_id == usuario_id
    ).first()

    if trabajador is None:
        raise HTTPException(
            status_code=404,
            detail="Trabajador no encontrado"
        )

    usuario = db.query(Usuario).filter(
        Usuario.id == usuario_id
    ).first()

    categoria = db.execute(
        text("""
            SELECT nombre
            FROM categorias
            WHERE id = :categoria_id
        """),
        {"categoria_id": trabajador.categoria_id}
    ).fetchone()

    nombre_categoria = categoria.nombre if categoria else "Sin categoría"

    if nombre_categoria == "Otro" and trabajador.categoria_personalizada:
        nombre_categoria = trabajador.categoria_personalizada

    return {
    "id": trabajador.id,
    "usuario_id": trabajador.usuario_id,
    "nombre": f"{usuario.nombre} {usuario.apellido}",
    "telefono": usuario.telefono,
    "categoria": nombre_categoria,
    "biografia": trabajador.biografia,
    "ciudad": trabajador.ciudad,
    "disponible": trabajador.disponible
}