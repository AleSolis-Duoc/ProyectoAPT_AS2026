import { Link } from "react-router-dom";


function Trabajador() {

    const usuario = JSON.parse(
        localStorage.getItem("usuario")
    );

    return (
        <main className="panel-trabajador">

            <section className="panel-titulo">

                <div>
                    <h1>Panel del trabajador</h1>

                    <p>
                        Administra tu perfil y muestra tus trabajos.
                    </p>
                </div>

            </section>


            <section className="panel-resumen">

                <div className="panel-datos">

                    <h2>
                        {usuario?.nombre || "Trabajador"}
                    </h2>

                    <p>
                        Trabajador independiente
                    </p>

                    <p>
                        Santiago, Chile
                    </p>

                </div>


                <div className="panel-acciones">

                    <Link
                        to="/perfil-trabajador"
                        className="panel-button"
                    >
                        Ver mi perfil
                    </Link>

                    <button
                        type="button"
                        className="panel-button secundario"
                    >
                        Reservas
                    </button>
                    <Link to="/perfil-trabajador">
                        Ver mi perfil público
                    </Link>
                </div>

            </section>


            <section className="panel-seccion">

                <h2>Portafolio</h2>

                <p>
                    Agrega y administra las imágenes que aparecerán
                    en tu perfil público.
                </p>

                <Link
                    to="/perfil-trabajador"
                    className="panel-link"
                >
                    Administrar portafolio
                </Link>

            </section>


            <section className="panel-seccion">

                <h2>Información del perfil</h2>

                <p>
                    Mantén actualizada tu información para que los
                    clientes puedan conocerte.
                </p>

                <Link
                    to="/perfil-trabajador"
                    className="panel-link"
                >
                    Ver información del perfil
                </Link>

            </section>

        </main>
    );
}

export default Trabajador;