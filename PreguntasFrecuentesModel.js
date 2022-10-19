import {DataTypes} from "squelize";
import db from "../database/db.js"


cons Preguntas_FrecuentesModel=db.define('Preguntas_Frecuentes',{
    ID_Preguntas_Frecuentes:{type:Datatypes.INTEGER, primary key:true},
    titulo:{type:Datatypes.STRING}
    categoria:{type:Datatypes.STRING}
    contenido:{type:Datatypes.STRING}
    ID_Carrera:{type:Datatypes.INTEGER}

})

export default Pregunta_FrecuenteModel