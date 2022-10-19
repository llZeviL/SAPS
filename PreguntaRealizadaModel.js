import {DataTypes} from "squelize";
import db from "../database/db.js"


cons Pregunta_RealizadaModel=db.define('Pregunta_Ralizada',{
    Estado:{type:Datatypes.INTEGER, primary key:true},
    Fecha_Pregunta:{type:Datatypes.STRING}
    ID_Pregunta:{type:Datatypes.INTEGER}
    ID_Estudiante:{type:Datatypes.INTEGER}
})

export default Pregunta_RealizadaModel