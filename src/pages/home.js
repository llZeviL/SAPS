import {React} from 'react';
import {Barra} from './barra';
import "../App.css"



export function Home1(){
    return(
        <div > 
           <Barra/> 

            <div>
                <button className="btn">Ingresar Pregunta</button>
                <button className='btn'>Ingresa solicitud</button>
                <br/>
                <button className='btn'>Preguntas Frecuentes</button>
                <button className='btn'>Estado de consultas</button>

            </div>
            </div>
    )
}