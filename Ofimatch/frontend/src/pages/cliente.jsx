import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

function Cliente() {

    const [profesionales, setProfesionales] = useState([]);
    const [categoriaSeleccionada, setCategoriaSeleccionada] = useState("Todos");
    const [cargando, setCargando] = useState(true);
    const navigate = useNavigate();
    
    useEffect(() => {

        fetch("http://127.0.0.1:8000/trabajadores/detalle")
            .then((respuesta) => respuesta.json())
            .then((datos) => {
                setProfesionales(datos);
                setCargando(false);
            })
            .catch((error) => {
                console.error("Error al obtener trabajadores:", error);
                setCargando(false);
            });

    }, []);

    const categorias = [
        "Todos",
        ...new Set(profesionales.map((profesional) => profesional.categoria))
    ];

    const profesionalesFiltrados =
        categoriaSeleccionada === "Todos"
            ? profesionales
            : profesionales.filter(
                (profesional) =>
                    profesional.categoria === categoriaSeleccionada
            );

    return (
        <main className="cliente">

            <section className="cliente-header">
                <h1>Encuentra un profesional</h1>
                <p>
                    Busca trabajadores independientes según el servicio que necesitas.
                </p>
            </section>

            <section className="categorias-cliente">

                {categorias.map((categoria) => (
                    <button
                        key={categoria}
                        onClick={() => setCategoriaSeleccionada(categoria)}
                        className={
                            categoriaSeleccionada === categoria
                                ? "categoria-activa"
                                : ""
                        }
                    >
                        {categoria}
                    </button>
                ))}

            </section>

            {cargando ? (

                <p>Cargando profesionales...</p>

            ) : (

                <section className="profesionales">

                    {profesionalesFiltrados.map((profesional) => (

                        <article
                            className="profesional-card"
                            key={profesional.id}
                        >

                            <h2>{profesional.nombre}</h2>

                            <p className="profesional-categoria">
                                {profesional.categoria}
                            </p>

                            <p>
                                {profesional.ciudad}
                            </p>

                            <p>
                                {profesional.descripcion}
                            </p>

                            <button
    onClick={() => navigate(`/perfil-trabajador/${profesional.id}`)}
>
    Ver perfil
</button>
                        </article>

                    ))}

                </section>

            )}

        </main>
    );
}

export default Cliente;