import {DataTypes} from "squelize";
import db from "../database/db.js"


cons Solicitud_RealizadaModel=db.define('Solicitud_Realizada',{
    Estado:{type:Datatypes.STRING},
    Fecha_Pregunta:{type:Datatypes.INTEGER}
    ID_Solicitud:{type:Datatypes.INTEGER}
    ID_Estudiante:{type:Datatypes.INTEGER}
})

export default Pregunta_RealizadaModel