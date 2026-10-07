import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

function PerfilTrabajador() {

    const { trabajadorId } = useParams();

    const [trabajador, setTrabajador] = useState(null);
    const [imagenes, setImagenes] = useState([]);
    const [imagenSeleccionada, setImagenSeleccionada] = useState(null);
    const usuario = JSON.parse(
        localStorage.getItem("usuario")
    );

    // Obtener información del trabajador
    useEffect(() => {

        let url = null;

        if (trabajadorId) {
            url = `http://127.0.0.1:8000/trabajadores/${trabajadorId}`;
        } else if (usuario) {
            url = `http://127.0.0.1:8000/trabajadores/usuario/${usuario.usuario_id}`;
        }

        if (!url) return;

        fetch(url)
            .then((respuesta) => {

                if (!respuesta.ok) {
                    throw new Error("No se pudo obtener el trabajador");
                }

                return respuesta.json();
            })
            .then((datos) => {
                setTrabajador(datos);
            })
            .catch((error) => {
                console.error("Error al obtener trabajador:", error);
            });

    }, [trabajadorId]);


    // Cargar portafolio guardado
    useEffect(() => {

        if (!trabajador) return;

        const guardadas = localStorage.getItem(
            `portfolio_${trabajador.id}`
        );

        if (guardadas) {
            setImagenes(JSON.parse(guardadas));
        }

    }, [trabajador]);


    // Seleccionar imágenes
    const seleccionarImagenes = (e) => {

        if (!trabajador) return;

        const archivos = Array.from(e.target.files);

        archivos.forEach((archivo) => {

            const lector = new FileReader();

            lector.onload = () => {

                const nuevaImagen = {
                    nombre: archivo.name,
                    url: lector.result
                };

                setImagenes((anteriores) => {

                    const nuevasImagenes = [
                        ...anteriores,
                        nuevaImagen
                    ];

                    localStorage.setItem(
                        `portfolio_${trabajador.id}`,
                        JSON.stringify(nuevasImagenes)
                    );

                    return nuevasImagenes;
                });

            };

            lector.readAsDataURL(archivo);
        });

    };


    if (!trabajador) {

        return (
            <main className="perfil-trabajador">
                <p>Cargando perfil...</p>
            </main>
        );

    }


    return (

        <main className="perfil-trabajador">

            <section className="perfil-header">

                <div>

                    <h1>
                        {trabajador.nombre_publico || trabajador.nombre}
                    </h1>

                    <p className="perfil-categoria">
                        {trabajador.categoria}
                    </p>

                    <p>
                        {trabajador.ciudad}
                    </p>

                    <p className="perfil-descripcion">
                        {trabajador.biografia ||
                            "Este trabajador todavía no ha agregado una descripción."}
                    </p>

                </div>


                <div className="perfil-acciones">

                    <button className="reservas-button">
                        Reservar servicio
                    </button>

                    <button
    className="contactar-button"
    onClick={() => {

        console.log("DATOS DEL TRABAJADOR:", trabajador);
console.log("TELEFONO:", trabajador.telefono);

if (!trabajador.telefono) {
    alert("El frontend no está recibiendo el teléfono.");
    return;
}

        const telefono = trabajador.telefono
            .replace(/\D/g, "");

        const telefonoWhatsApp =
            telefono.startsWith("56")
                ? telefono
                : `56${telefono}`;

        const mensaje = encodeURIComponent(
            "Hola, vi tu perfil en OfiMatch y me gustaría consultar por tus servicios."
        );

        window.open(
            `https://wa.me/${telefonoWhatsApp}?text=${mensaje}`,
            "_blank"
        );
    }}
>
    Contactar
</button>

                </div>

            </section>


            <section className="portfolio">

                <h2>Portafolio</h2>


                {!trabajadorId && (

                    <div className="portfolio-upload">

                        <p>
                            Agrega imágenes a tu portafolio:
                        </p>

                        <input
                            type="file"
                            accept="image/*"
                            multiple
                            onChange={seleccionarImagenes}
                        />

                    </div>

                )}


                <div className="portfolio-grid">

                    {imagenes.length === 0 ? (

                        <p className="portfolio-vacio">
                            Este trabajador todavía no tiene imágenes
                            en su portafolio.
                        </p>

                    ) : (

                        imagenes.map((imagen, index) => (

                            <div
                                className="portfolio-item"
                                key={index}
                                onClick={() => setImagenSeleccionada(imagen.url)}
                            >
                                <img
                                    src={imagen.url}
                                    alt={imagen.nombre}
                                />
                            </div>

                        ))

                    )}

                </div>
                {imagenSeleccionada && (

                    <div
                        className="portfolio-modal"
                        onClick={() => setImagenSeleccionada(null)}
                    >

                        <img
                            src={imagenSeleccionada}
                            alt="Imagen del portafolio"
                        />

                    </div>

                )}
            </section>

        </main>

    );

}

export default PerfilTrabajador;