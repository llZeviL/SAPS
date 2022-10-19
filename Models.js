
const Pregunta = db.define('preguntas',{
	ID_Pregunta: {type:DataTypes.INTEGER , primaryKey:true},
	Prioridad: {type:DataTypes.STRING},
	Contenido: {type:DataTypes.STRING},
	Categoria: {type:DataTypes.STRING},
	Destinatario: {type:DataTypes.STRING},
	Fecha_Pregunta: {type:DataTypes.DATE}

})
export default Pregunta

const Solicitud = db.define('solicitudes',{
	ID_Solicitud: {type:DataTypes.INTEGER , primaryKey:true},
	Prioridad: {type:DataTypes.STRING},
	Contenido: {type:DataTypes.STRING},
	Categoria: {type:DataTypes.STRING},
	Fecha_Solicitud: {type:DataTypes.DATE}
})
export default Solicitud


const Cursa_Ramo = db.define('cursa_ramos',{
	ID_Estudiante: {type:DataTypes.INTEGER , primaryKey:true},
	ID_Ramo: {type:DataTypes.INTEGER , primaryKey:true}
})
export default Cursa_Ramo

const Carrera = db.define('carreras',{
	ID_Carrera: {type:DataTypes.INTEGER , primaryKey:true},
	Nombre_Carrera: {type:DataTypes.STRING}
})
export default Carrera

