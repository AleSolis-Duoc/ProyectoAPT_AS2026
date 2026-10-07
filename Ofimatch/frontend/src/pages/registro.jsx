import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import AuthLayout from "../components/AuthLayout";

function Registro() {

    const navigate = useNavigate();

    const [categorias, setCategorias] = useState([]);

    const [formulario, setFormulario] = useState({
        nombre: "",
        apellido: "",
        email: "",
        password: "",
        telefono: "",
        tipo_usuario: "cliente",
        categoria_id: "",
        categoria_personalizada: ""
    });

    useEffect(() => {

        fetch("http://127.0.0.1:8000/categorias")
            .then((respuesta) => respuesta.json())
            .then((datos) => {
                setCategorias(datos);
            })
            .catch((error) => {
                console.error("Error al obtener categorías:", error);
            });

    }, []);

    const manejarCambio = (e) => {

        setFormulario({
            ...formulario,
            [e.target.name]: e.target.value
        });

    };

    const manejarRegistro = async (e) => {

        e.preventDefault();

        try {

            const respuesta = await fetch(
                "http://127.0.0.1:8000/usuarios",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        nombre: formulario.nombre,
                        apellido: formulario.apellido,
                        email: formulario.email,
                        password: formulario.password,
                        telefono: formulario.telefono,
                        tipo_usuario: formulario.tipo_usuario,
                        categoria_id: formulario.tipo_usuario === "trabajador"
                            ? Number(formulario.categoria_id)
                            : null,
                        categoria_personalizada:
                            formulario.tipo_usuario === "trabajador"
                                ? formulario.categoria_personalizada
                                : null
                    })
                }
            );

            const datos = await respuesta.json();

            if (!respuesta.ok) {
                alert(datos.detail || "Error al registrar usuario");
                return;
            }

            alert("Usuario registrado correctamente");

            navigate("/login");

        } catch (error) {

            console.error(error);
            alert("No se pudo conectar con el servidor");

        }

    };

    return (
        <AuthLayout>

            <div className="auth-header">

                <h1>Crear cuenta</h1>

                <p>
                    Únete a OfiMatch
                </p>

            </div>


            <form
                className="auth-form"
                onSubmit={manejarRegistro}
            >

                <label>Nombre</label>

                <input
                    type="text"
                    name="nombre"
                    placeholder="Tu nombre"
                    value={formulario.nombre}
                    onChange={manejarCambio}
                    required
                />


                <label>Apellido</label>

                <input
                    type="text"
                    name="apellido"
                    placeholder="Tu apellido"
                    value={formulario.apellido}
                    onChange={manejarCambio}
                    required
                />


                <label>Correo electrónico</label>

                <input
                    type="email"
                    name="email"
                    placeholder="tu@email.com"
                    value={formulario.email}
                    onChange={manejarCambio}
                    required
                />


                <label>Contraseña</label>

                <input
                    type="password"
                    name="password"
                    placeholder="Crea una contraseña"
                    value={formulario.password}
                    onChange={manejarCambio}
                    required
                />


                <label>Teléfono</label>

                <input
                    type="text"
                    name="telefono"
                    placeholder="912345678"
                    value={formulario.telefono}
                    onChange={manejarCambio}
                />


                <label>Tipo de cuenta</label>

                <select
                    name="tipo_usuario"
                    value={formulario.tipo_usuario}
                    onChange={manejarCambio}
                >

                    <option value="cliente">
                        Cliente
                    </option>

                    <option value="trabajador">
                        Trabajador independiente
                    </option>

                </select>


                {formulario.tipo_usuario === "trabajador" && (

                    <>

                        <label>Oficio</label>

                        <select
                            name="categoria_id"
                            value={formulario.categoria_id}
                            onChange={manejarCambio}
                            required
                        >

                            <option value="">
                                Selecciona tu oficio
                            </option>

                            {categorias.map((categoria) => (

                                <option
                                    key={categoria.id}
                                    value={categoria.id}
                                >
                                    {categoria.nombre}
                                </option>

                            ))}

                        </select>


                        {categorias.some(
                            (categoria) =>
                                categoria.id === Number(formulario.categoria_id) &&
                                categoria.nombre === "Otro"
                        ) && (

                                <>
                                    <label>
                                        Especifica tu oficio
                                    </label>

                                    <input
                                        type="text"
                                        name="categoria_personalizada"
                                        placeholder="Ej: Ceramista"
                                        value={formulario.categoria_personalizada}
                                        onChange={manejarCambio}
                                        required
                                    />
                                </>

                            )}

                    </>

                )}


                <button type="submit">
                    Crear cuenta
                </button>

            </form>


            <p className="auth-footer">

                ¿Ya tienes una cuenta?

                <a href="/login">
                    {" "}Iniciar sesión
                </a>

            </p>

        </AuthLayout>
    );
}

export default Registro;