import { Link } from "react-router-dom";

function Navbar() {
    return (
        <nav className="navbar">
            <Link to="/" className="logo">
                OfiMatch
            </Link>

            <div className="nav-links">
                <Link to="/">Inicio</Link>
                <Link to="/login">Iniciar sesión</Link>
                <Link to="/register" className="register-button">
                    Registrarse
                </Link>
            </div>
        </nav>
    );
}

export default Navbar;