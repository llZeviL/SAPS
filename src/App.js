import React from "react";
import { Route, Routes, BrowserRouter } from "react-router-dom";
import { Home1 } from "./pages/home";
import {Login} from "./pages/login";
import { Directore } from "./pages/director";
import { Secretari } from "./pages/secretaria";




/*import Login from './pages/login';*/

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/home" element={<Home1 />} />
        <Route path="/login.js" element={<Login/>} />
        <Route path="/director.js" element={<Directore/>} />
        <Route path="/secretaria.js" element={<Secretari/>} />

       
      </Routes>
    </BrowserRouter>
  )
};



