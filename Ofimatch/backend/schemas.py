from pydantic import BaseModel
from typing import Optional


class UsuarioBase(BaseModel):
    nombre: str
    apellido: str
    email: str
    password: str
    telefono: Optional[str] = None
    tipo_usuario: str
    categoria_id: Optional[int] = None
    categoria_personalizada: Optional[str] = None


class UsuarioCrear(UsuarioBase):
    pass


class UsuarioRespuesta(BaseModel):
    id: int
    nombre: str
    apellido: str
    email: str
    telefono: Optional[str] = None
    tipo_usuario: str

    class Config:
        from_attributes = True


class TrabajadorBase(BaseModel):
    usuario_id: int
    categoria_id: int
    nombre_publico: str
    biografia: Optional[str] = None
    ciudad: Optional[str] = None
    disponible: bool = True
    categoria_personalizada: Optional[str] = None

class TrabajadorCrear(TrabajadorBase):
    pass


class TrabajadorRespuesta(TrabajadorBase):
    id: int

    class Config:
        from_attributes = True


class LoginDatos(BaseModel):
    email: str
    password: str