import React from "react";
import Logo from "../images/logo.png";
import { NavLink } from "react-router-dom";
import "./login";
import "./director"
import "./home"

export function Barra() {
  return (
    <div className="Barra">
      <div>
        <img src={Logo} alt="Logo" className="center" />
      </div>
      <nav className="Nav-Info">
        <ul>
          <br />
          <button className="pumba">
          <NavLink to="/director.js">Director</NavLink>
          </button>
          <button className="pumba">
          <NavLink to="/home">Estudiante</NavLink>
          </button>
          <button className="pumba">
          <NavLink to="/secretaria.js">secretaria</NavLink>
          </button>
          <button className="pumba">
            <NavLink to="/login.js">Cerrar sesion</NavLink>
            <br />
          </button>
          
        </ul>
      </nav>
    </div>
  );
}
