import res from "express/lib/response.js";
import DirectorModel from "../models/DirectorModel.js";

export const getAllDirector = async(req,res)=> {
    try {
        const Directores = await DirectorModel.findAll()
            res.json(Directores)
    }catch (error){
        res.json({message: error.message})
    }
}

export const getDirector = async(req,res)=> {
    try {
        const Director = await DirectorModel.findAll({
            where:{id:req.params.id}
        })
        res.json(Director[0])
    }catch (error){
        
    }
}

export const createDirector = async(req,res)=> {
    try {
        await DirectorModel.create(req.body)
        res.json({
            "message":"Director creado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const updateDirector = async(req,res)=> {
    try {
        await DirectorModel.update(req.body, {
            where: {id:req.params.id}
        })
        res.json({
            "message":"Director actualizado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const deleteDirector = async(req,res)=> {
    try {
        await DirectorModel.destroy({
            where: {id:req.params.id}
        })
        res.json({
            "message":"Director eliminado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}