import { Sequelize } from "sequelize";

const db= new Sequelize('prueba','root','ezioflorenzia32',{
    host:'localhost',
    dialect:'mysql'
})

export default db