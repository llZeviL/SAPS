import res from "express/lib/response.js";
import RolModel from "../models/Pregunta_RealizadaModel.js";

export const getAllPregunta_Realizadas = async(req,res)=> {
    try {
        const Pregunta_Realizadas = await Pregunta_RealizadaModel.findAll()
            res.json(Pregunta_Realizadas)
    }catch (error){
        res.json({message: error.message})
    }
}

export const getPregunta_Realizada = async(req,res)=> {
    try {
        const Pregunta_Realizada = await Pregunta_Realizada.findAll({
            where:{id:req.params.id}
        })
        res.json(Rol[0])
    }catch (error){
        
    }
}

export const createPregunta_Realizada = async(req,res)=> {
    try {
        await Pregunta_RealizadaModel.create(req.body)
        res.json({
            "message":"Pregunta Realizada creado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const updatePregunta_Realizada = async(req,res)=> {
    try {
        await Pregunta_RealizadaModel.update(req.body, {
            where: {id:req.params.id}
        })
        res.json({
            "message":"Pregunta Realizada actualizado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const deletePregunta_Realizada = async(req,res)=> {
    try {
        await Pregunta_RealizadaModel.destroy({
            where: {id:req.params.id}
        })
        res.json({
            "message":"Pregunta_Realizada eliminado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}