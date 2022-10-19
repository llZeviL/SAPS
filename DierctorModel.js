//importamos la conexion a db
import db from "../database/db.js";
// importamos sequelize
import DataType from "sequelize";

const DirectorModel = db.define('saps',{
    Nombre_Director: {type: DataType.STRING},
    Email: {type: DataType.STRING},
    Telefono: {type: DataType.NUMBER},
    contrasenia: {type: DataType.STRING},
    ID_Rol: {type: DataType.NUMBER},
    ID_Carrera: {type: DataType.NUMBER},
})

export default DirectorModel;