import res from "express/lib/response.js";
import RolModel from "../models/RolModel.js";

export const getAllSolicitud_Realizadas = async(req,res)=> {
    try {
        const Solicitud_Realizadas = await Solicitud_RealizadaModel.findAll()
            res.json(Solicitud_Realizadas)
    }catch (error){
        res.json({message: error.message})
    }
}

export const getSolicitud_Realizada = async(req,res)=> {
    try {
        const Solicitud_Realizada = await Solicitud_RealizadaModel.findAll({
            where:{id:req.params.id}
        })
        res.json(Rol[0])
    }catch (error){
        
    }
}

export const createSolicitud_Realizada = async(req,res)=> {
    try {
        await Solicitud_RealizadaModel.create(req.body)
        res.json({
            "message":"Solicitud Realizada creado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const updateSolicitud_Realizada = async(req,res)=> {
    try {
        await Solicitud_RealizadaModel.update(req.body, {
            where: {id:req.params.id}
        })
        res.json({
            "message":"Solicitud_Realizada actualizado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const deleteSolicitud_Realizada = async(req,res)=> {
    try {
        await Solicitud_RealizadaModel.destroy({
            where: {id:req.params.id}
        })
        res.json({
            "message":"Solicitud_Realizada eliminado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}