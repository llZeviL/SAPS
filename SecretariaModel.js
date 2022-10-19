//importamos la conexion a db
import db from "../database/db.js";
// importamos sequelize
import DataType from "sequelize";

const SecretariaModel = db.define('saps',{
    Nombre_Secretaria: {type: DataType.STRING},
    Email: {type: DataType.STRING},
    Telefono: {type: DataType.NUMBER},
    contrasenia: {type: DataType.STRING},
    ID_Rol: {type: DataType.NUMBER},
})

export default SecretariaModel;