import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

const TRABAJADORES_POR_PAGINA = 5;

function Inicio() {
const navigate = useNavigate();

const [profesionales, setProfesionales] = useState([]);
const [busqueda, setBusqueda] = useState("");
const [paginaActual, setPaginaActual] = useState(1);
const [cargando, setCargando] = useState(true);
const [error, setError] = useState(false);

useEffect(() => {
    fetch("http://127.0.0.1:8000/trabajadores/detalle")
        .then((respuesta) => {
            if (!respuesta.ok) {
                throw new Error("Error al cargar profesionales");
            }
            return respuesta.json();
        })
        .then((datos) => {
            setProfesionales(Array.isArray(datos) ? datos : []);
        })
        .catch((error) => {
            console.error(error);
            setError(true);
        })
        .finally(() => setCargando(false));
}, []);

// Filtrar profesionales según el texto ingresado.
const resultados = profesionales.filter((p) => {
    const termino = busqueda.toLowerCase().trim();

    const texto = [
        p.nombre,
        p.categoria,
        p.ciudad,
        p.descripcion
    ]
        .filter(Boolean)
        .join(" ")
        .toLowerCase();

    return texto.includes(termino);
});

// Calcular las páginas necesarias.
const totalPaginas = Math.ceil(
    resultados.length / TRABAJADORES_POR_PAGINA
);

const indiceInicial = (paginaActual - 1) * TRABAJADORES_POR_PAGINA;
const indiceFinal = indiceInicial + TRABAJADORES_POR_PAGINA;

const profesionalesPagina = resultados.slice(
    indiceInicial,
    indiceFinal
);

// Volver a la primera página cuando cambia la búsqueda.
useEffect(() => {
    setPaginaActual(1);
}, [busqueda]);

// Evitar quedarse en una página inexistente si cambian los resultados.
useEffect(() => {
    if (totalPaginas > 0 && paginaActual > totalPaginas) {
        setPaginaActual(totalPaginas);
    }
}, [paginaActual, totalPaginas]);

const cambiarPagina = (pagina) => {
    setPaginaActual(pagina);
};

return (
    <main className="home home-nueva">
        <div className="hero-imagenes-fondo" aria-hidden="true">
            <div className="imagen-flotante imagen-1">
                <img
                    src="https://images.unsplash.com/photo-1679621550970-32d6587b62c4?auto=format&fit=crop&w=500&q=80"
                    alt=""
                />
            </div>

            <div className="imagen-flotante imagen-2">
                <img
                    src="https://frisor.ua/images/statti/vypadenie_volos/vypadenie_volos_04.jpg"
                    alt=""
                />
            </div>

            <div className="imagen-flotante imagen-3">
                <img
                    src="https://static.tildacdn.net/tild6536-3064-4137-a465-346131363663/_.png"
                    alt=""
                />
            </div>

            <div className="imagen-flotante imagen-4">
                <img
                    src="https://images.unsplash.com/photo-1726671848984-98d836437f3a?auto=format&fit=crop&w=500&q=80"
                    alt=""
                />
            </div>
        </div>

        <section className="hero hero-nueva">
            <span className="hero-tag">
                OFIMATCH · SERVICIOS INDEPENDIENTES
            </span>

            <h1>
                El talento que buscas,
                <br />
                más cerca de ti.
            </h1>

            <p>
                Encuentra profesionales independientes, conoce su trabajo
                y contacta directamente con ellos.
            </p>

            <button
                className="hero-button"
                onClick={() =>
                    document.getElementById("seccion-busqueda")
                        ?.scrollIntoView({ behavior: "smooth" })
                }
            >
                Encontrar profesionales
            </button>
        </section>

        <section className="busqueda-slide" id="seccion-busqueda">
            <div className="busqueda-contenido">
                <span className="seccion-etiqueta">
                    ENCUENTRA LO QUE NECESITAS
                </span>

                <h2>Busca tu próximo profesional</h2>

                <p>
                    Escribe un oficio, un nombre o una ciudad para comenzar.
                </p>

                <form
                    className="busqueda-box"
                    onSubmit={(e) => {
                        e.preventDefault();

                        document.getElementById("resultados")
                            ?.scrollIntoView({ behavior: "smooth" });
                    }}
                >
                    <input
                        type="search"
                        placeholder="Ej.: tatuador, fotografía, Santiago..."
                        value={busqueda}
                        onChange={(e) => setBusqueda(e.target.value)}
                    />

                    <button type="submit">Buscar</button>
                </form>

                <div className="busqueda-nota">
                    Explora perfiles públicos sin necesidad de registrarte.
                </div>
            </div>
        </section>

        <section className="servicios-slide">
            <div className="servicios-contenido">
                <span className="seccion-etiqueta">
                    UNA FORMA MÁS SIMPLE DE CONECTAR
                </span>

                <h2>¿Qué puedes hacer en OfiMatch?</h2>

                <p className="servicios-intro">
                    Todo lo necesario para encontrar y conocer a profesionales
                    independientes en un solo lugar.
                </p>

                <div className="servicios-grid">
                    <article className="servicio-box">
                        <span className="servicio-numero">01</span>
                        <h3>Encuentra profesionales</h3>
                        <p>
                            Explora personas que ofrecen servicios y busca
                            según su especialidad o ubicación.
                        </p>
                    </article>

                    <article className="servicio-box">
                        <span className="servicio-numero">02</span>
                        <h3>Revisa sus perfiles</h3>
                        <p>
                            Conoce su experiencia, descripción y trabajos
                            antes de decidir con quién contactar.
                        </p>
                    </article>

                    <article className="servicio-box">
                        <span className="servicio-numero">03</span>
                        <h3>Contacta directamente</h3>
                        <p>
                            Consulta precios, disponibilidad y detalles
                            del servicio directamente con cada profesional.
                        </p>
                    </article>
                </div>
            </div>
        </section>

        <section className="resultados-slide" id="resultados">
            <div className="resultados-contenido">
                <span className="seccion-etiqueta">
                    DIRECTORIO OFIMATCH
                </span>

                <h2>
                    {busqueda.trim()
                        ? `Resultados para "${busqueda.trim()}"`
                        : "Profesionales registrados"}
                </h2>

                {cargando ? (
                    <p className="resultados-mensaje">
                        Cargando profesionales...
                    </p>
                ) : error ? (
                    <p className="resultados-mensaje">
                        No se pudieron cargar los profesionales.
                        Comprueba que el backend esté funcionando.
                    </p>
                ) : resultados.length === 0 ? (
                    <p className="resultados-mensaje">
                        No se encontraron profesionales. Prueba con otro término.
                    </p>
                ) : (
                    <>
                        <div className="resultados-resumen">
                            <span>
                                {resultados.length}{" "}
                                {resultados.length === 1
                                    ? "profesional encontrado"
                                    : "profesionales encontrados"}
                            </span>

                            <span>
                                Página {paginaActual} de {totalPaginas}
                            </span>
                        </div>

                        <div className="profesionales">
                            {profesionalesPagina.map((p) => (
                                <article
                                    className="profesional-card"
                                    key={p.id}
                                >
                                    <div className="profesional-card-contenido">
                                        <h3>
                                            {p.nombre || "Profesional sin nombre"}
                                        </h3>

                                        <span className="profesional-categoria">
                                            {p.categoria || "Oficio no indicado"}
                                        </span>

                                        <p className="profesional-ubicacion">
                                            <span aria-hidden="true">⌖ </span>
                                            {p.ciudad || "Ubicación no indicada"}
                                        </p>

                                        <p className="profesional-descripcion">
                                            {p.descripcion ||
                                                "Profesional independiente en OfiMatch."}
                                        </p>
                                    </div>

                                    <button
                                        className="profesional-boton"
                                        type="button"
                                        onClick={() =>
                                            navigate(
                                                `/perfil-trabajador/${p.id}`
                                            )
                                        }
                                    >
                                        Ver perfil
                                        <span aria-hidden="true"> →</span>
                                    </button>
                                </article>
                            ))}
                        </div>

                        {totalPaginas > 1 && (
                            <nav
                                className="paginacion"
                                aria-label="Páginas de profesionales"
                            >
                                <button
                                    type="button"
                                    className="pagina-flecha"
                                    disabled={paginaActual === 1}
                                    onClick={() =>
                                        cambiarPagina(paginaActual - 1)
                                    }
                                >
                                    Anterior
                                </button>

                                {Array.from(
                                    { length: totalPaginas },
                                    (_, i) => i + 1
                                ).map((pagina) => (
                                    <button
                                        type="button"
                                        key={pagina}
                                        className={`pagina-numero ${
                                            paginaActual === pagina
                                                ? "pagina-activa"
                                                : ""
                                        }`}
                                        aria-current={
                                            paginaActual === pagina
                                                ? "page"
                                                : undefined
                                        }
                                        onClick={() => cambiarPagina(pagina)}
                                    >
                                        {pagina}
                                    </button>
                                ))}

                                <button
                                    type="button"
                                    className="pagina-flecha"
                                    disabled={paginaActual === totalPaginas}
                                    onClick={() =>
                                        cambiarPagina(paginaActual + 1)
                                    }
                                >
                                    Siguiente
                                </button>
                            </nav>
                        )}
                    </>
                )}
            </div>
        </section>
    </main>
);

}

export default Inicio;