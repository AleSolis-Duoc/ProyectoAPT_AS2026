import { Link } from "react-router-dom";

function Inicio() {
    return (
        <main className="home">

            <section className="hero">
                <span className="hero-tag">
                    Profesionales independientes
                </span>

                <h1>
                    Encuentra a la persona
                    <br />
                    indicada para tu servicio.
                </h1>

                <p>
                    Descubre profesionales independientes, revisa sus trabajos
                    y contacta directamente con ellos.
                </p>

                <Link to="/register" className="hero-button">
                    Comenzar a buscar
                </Link>
            </section>

            <section className="categories">
                <h2>Explora por categoría</h2>

                <div className="category-grid">

                    <div className="category-card">
                        <span>🎨</span>
                        <h3>Tatuajes</h3>
                    </div>

                    <div className="category-card">
                        <span>💈</span>
                        <h3>Barbería</h3>
                    </div>

                    <div className="category-card">
                        <span>✂️</span>
                        <h3>Peluquería</h3>
                    </div>

                    <div className="category-card">
                        <span>💅</span>
                        <h3>Manicure</h3>
                    </div>

                    <div className="category-card">
                        <span>📷</span>
                        <h3>Fotografía</h3>
                    </div>

                    <div className="category-card">
                        <span>🔧</span>
                        <h3>Otros oficios</h3>
                    </div>

                </div>
            </section>

        </main>
    );
}

export default Inicio;