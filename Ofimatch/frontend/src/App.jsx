import { BrowserRouter, Routes, Route } from "react-router-dom";
import "./App.css";
import Navbar from "./components/Navbar";
import Inicio from "./pages/inicio";
import Login from "./pages/login";
import Registro from "./pages/registro";
import PerfilTrabajador from "./pages/perfilTrabajador";
import Trabajador from "./pages/trabajador";
import Cliente from "./pages/cliente";
import Admin from "./pages/admin";

function App() {
    return (
        <BrowserRouter>

            <Navbar />

            <Routes>
                <Route
                    path="/trabajador"
                    element={<Trabajador />}
                />
                <Route path="/"
                    element={<Inicio />} />

                <Route path="/login"
                    element={<Login />} />

                <Route path="/register"
                    element={<Registro />} />

                <Route
                    path="/perfil-trabajador/:trabajadorId"
                    element={<PerfilTrabajador />}
                />
                <Route
                    path="/cliente"
                    element={<Cliente />}
                />
                <Route
                    path="/admin"
                    element={<Admin />}

                />
                <Route
                    path="/perfil-trabajador"
                    element={<PerfilTrabajador />}
                />
                <Route
                    path="/perfil-trabajador/:trabajadorId"
                    element={<PerfilTrabajador />}
                />
            </Routes>

        </BrowserRouter>
    );
}

export default App;