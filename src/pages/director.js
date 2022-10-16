import {React} from 'react' ;
import {Barra} from './barra';
import "../App.css"


export function Directore(){
    return(
        <div>
           <Barra/> 
            <div>
                <button className="btn">Visualizar Preguntas</button>
                <button className='btn'>Visualizar solicitudes</button>
                <br/>
                <button className='btn'>Editar Preguntas Frecuentes</button>
                <button className='btn'>Visualizar Estadisticas</button>
            </div>
            </div>
    )
}