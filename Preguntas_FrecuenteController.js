import res from "express/lib/response.js";
import Preguntas_FrecuentesModel from "../models/PreguntasFrecuentesModel.js";

export const getAllPreguntas_Frecuentes = async(req,res)=> {
    try {
        const Preguntas_Frecuentes = await Preguntas_FrecuentesModel.findAll()
            res.json(Preguntas_Frecuentes)
    }catch (error){
        res.json({message: error.message})
    }
}

export const getPreguntas_Frecuentes = async(req,res)=> {
    try {
        const Preguntas_frecuentes = await Preguntas_frecuentesModel.findAll({
            where:{id:req.params.id}
        })
        res.json(Rol[0])
    }catch (error){
        
    }
}

export const createPreguntas_frecuentes = async(req,res)=> {
    try {
        await Preguntas_frecuentesModel.create(req.body)
        res.json({
            "message":"Preguntas frecuentes creada correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const updatePreguntas_frecuentes = async(req,res)=> {
    try {
        await Preguntas_frecuentesModel.update(req.body, {
            where: {id:req.params.id}
        })
        res.json({
            "message":"Preguntas frecuentes actualizada correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const deletePreguntas_frecuentes = async(req,res)=> {
    try {
        await RolModel.destroy({
            where: {id:req.params.id}
        })
        res.json({
            "message":"Preguntas frecuentes eliminado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}