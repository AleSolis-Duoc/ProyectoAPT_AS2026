import { useState } from "react";
import { useNavigate } from "react-router-dom";
import AuthLayout from "../components/AuthLayout";

function Login() {

    const navigate = useNavigate();

    const [formulario, setFormulario] = useState({
        email: "",
        password: ""
    });

    const manejarCambio = (e) => {
        setFormulario({
            ...formulario,
            [e.target.name]: e.target.value
        });
    };

    const manejarLogin = async (e) => {
        e.preventDefault();

        try {
            const respuesta = await fetch("http://127.0.0.1:8000/login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(formulario)
            });

            const datos = await respuesta.json();

            if (!respuesta.ok) {
                alert(datos.detail || "Error al iniciar sesión");
                return;
            }

            localStorage.setItem(
                "usuario",
                JSON.stringify(datos)
            );

            alert(`Bienvenido, ${datos.nombre}`);

            if (datos.tipo_usuario === "cliente") {
                navigate("/cliente");
            } else if (datos.tipo_usuario === "trabajador") {
                navigate("/trabajador");
            } else if (datos.tipo_usuario === "admin") {
                navigate("/admin");
            }

        } catch (error) {
            console.error(error);
            alert("No se pudo conectar con el servidor");
        }
    };

    return (
        <AuthLayout>

            <div className="auth-header">
                <h1>Iniciar sesión</h1>
                <p>Ingresa a tu cuenta de OfiMatch</p>
            </div>

            <form className="auth-form" onSubmit={manejarLogin}>

                <label>Correo electrónico</label>

                <input
                    type="email"
                    name="email"
                    placeholder="tu@email.com"
                    value={formulario.email}
                    onChange={manejarCambio}
                />

                <label>Contraseña</label>

                <input
                    type="password"
                    name="password"
                    placeholder="Tu contraseña"
                    value={formulario.password}
                    onChange={manejarCambio}
                />

                <button type="submit">
                    Iniciar sesión
                </button>

            </form>

            <p className="auth-footer">
                ¿No tienes una cuenta?
                <a href="/register"> Registrarse</a>
            </p>

        </AuthLayout>
    );
}

export default Login;