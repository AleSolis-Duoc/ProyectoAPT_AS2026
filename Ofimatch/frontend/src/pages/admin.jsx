import { useEffect, useState } from "react";

function Admin() {

    const [estadisticas, setEstadisticas] = useState({
        usuarios: 0,
        trabajadores: 0,
        clientes: 0,
        reservas: 0
    });

    useEffect(() => {

        fetch("http://127.0.0.1:8000/admin/estadisticas")
            .then((respuesta) => respuesta.json())
            .then((datos) => {
                setEstadisticas(datos);
            })
            .catch((error) => {
                console.error("Error al obtener estadísticas:", error);
            });

    }, []);

    return (
        <main className="admin">

            <section className="admin-header">

                <h1>Panel de administración</h1>

                <p>
                    Administración general de la plataforma OfiMatch.
                </p>

            </section>


            <section className="admin-estadisticas">

                <div className="admin-stat">
                    <span>Usuarios registrados</span>
                    <strong>{estadisticas.usuarios}</strong>
                </div>

                <div className="admin-stat">
                    <span>Trabajadores</span>
                    <strong>{estadisticas.trabajadores}</strong>
                </div>

                <div className="admin-stat">
                    <span>Clientes</span>
                    <strong>{estadisticas.clientes}</strong>
                </div>

                <div className="admin-stat">
                    <span>Reservas</span>
                    <strong>{estadisticas.reservas}</strong>
                </div>

            </section>


            <section className="admin-seccion">

                <h2>Administración</h2>

                <div className="admin-opciones">

                    <button type="button">
                        Gestionar usuarios
                    </button>

                    <button type="button">
                        Gestionar trabajadores
                    </button>

                    <button type="button">
                        Revisar categorías
                    </button>

                    <button type="button">
                        Revisar reservas
                    </button>

                </div>

            </section>


            <section className="admin-seccion">

                <h2>Actividad reciente</h2>

                <div className="admin-tabla">

                    <div className="admin-fila admin-fila-cabecera">
                        <span>Usuario</span>
                        <span>Tipo</span>
                        <span>Fecha</span>
                        <span>Estado</span>
                    </div>

                    <div className="admin-fila">
                        <span>Alex Tattoo</span>
                        <span>Trabajador</span>
                        <span>Hoy</span>
                        <span>Activo</span>
                    </div>

                    <div className="admin-fila">
                        <span>Juan Pérez</span>
                        <span>Cliente</span>
                        <span>Hoy</span>
                        <span>Activo</span>
                    </div>

                    <div className="admin-fila">
                        <span>Studio Nails</span>
                        <span>Trabajador</span>
                        <span>Ayer</span>
                        <span>Activo</span>
                    </div>

                </div>

            </section>

        </main>
    );
}

export default Admin;