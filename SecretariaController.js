import res from "express/lib/response.js";
import SecretariaModel from "../models/SecretariaModel.js";

export const getAllSecretaria = async(req,res)=> {
    try {
        const Secretarias = await SecretariaModel.findAll()
            res.json(Secretarias)
    }catch (error){
        res.json({message: error.message})
    }
}

export const getSecretaria = async(req,res)=> {
    try {
        const Secretaria = await SecretariaModel.findAll({
            where:{id:req.params.id}
        })
        res.json(Secretaria[0])
    }catch (error){
        
    }
}

export const createSecretaria = async(req,res)=> {
    try {
        await SecretariaModel.create(req.body)
        res.json({
            "message":"Secretaria creado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const updateSecretaria = async(req,res)=> {
    try {
        await SecretariaModel.update(req.body, {
            where: {id:req.params.id}
        })
        res.json({
            "message":"Secretaria actualizado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}

export const deleteSecretaria = async(req,res)=> {
    try {
        await SecretariaModel.destroy({
            where: {id:req.params.id}
        })
        res.json({
            "message":"Secretaria eliminado correctamente"
        })
    }catch (error){
        res.json({message: error.message})
    }
}