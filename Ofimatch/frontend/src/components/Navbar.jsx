import { Link, useNavigate } from "react-router-dom";

function Navbar() {
    const navigate = useNavigate();

    const usuario = JSON.parse(
        localStorage.getItem("usuario")
    );

    const cerrarSesion = () => {
        localStorage.removeItem("usuario");
        navigate("/login");
        window.location.reload();
    };

    return (
        <nav className="navbar">
            <Link to="/" className="logo">
                OfiMatch
            </Link>

            <div className="nav-links">
                <Link to="/">Inicio</Link>

                {!usuario ? (
                    <>
                        <Link to="/login">Iniciar sesión</Link>

                        <Link
                            to="/register"
                            className="register-button"
                        >
                            Registrarse
                        </Link>
                    </>
                ) : (
                    <>
                        {usuario.tipo_usuario === "cliente" && (
                            <Link to="/cliente">
                                Buscar profesionales
                            </Link>
                        )}

                        {usuario.tipo_usuario === "trabajador" && (
                            <Link to="/trabajador">
                                Mi panel
                            </Link>
                        )}

                        {usuario.tipo_usuario === "admin" && (
                            <Link to="/admin">
                                Administración
                            </Link>
                        )}

                        <button onClick={cerrarSesion}>
                            Cerrar sesión
                        </button>
                    </>
                )}
            </div>
        </nav>
    );
}

export default Navbar;