import res from "express/lib/response.js";
import ProfesorModel from "../models/ProfesorModel.js";

export const getAllProfesor = async(req,res)=> {
    try {
        const Profesores = await ProfesorModel.findAll()
            res.json(Profesores)
    }catch (error){
        res.json({message: error.message})
    }
}

export const getProfesor = async(req,res)=> {
    try {
        const Profesor = await ProfesorModel.findAll({
            where:{id:req.params.id}
        })
        res.json(Profesor[0])
    }catch (error){
        
    }
}

export const createProfesor = async(req,res)=> {
    try {
        await ProfesorModel.create(req.body)
        res.json({
            "message":"Profesor creado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const updateProfesor = async(req,res)=> {
    try {
        await ProfesorModel.update(req.body, {
            where: {id:req.params.id}
        })
        res.json({
            "message":"Profesor actualizado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const deleteProfesor = async(req,res)=> {
    try {
        await ProfesorModel.destroy({
            where: {id:req.params.id}
        })
        res.json({
            "message":"Profesor eliminado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}