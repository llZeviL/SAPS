import { DataTypes } from "sequelize";
import db from "../database/db.js";

const BlogModel=db.define('blogs', {
    title: {type:DataTypes.STRING},
    content: {type:DataTypes.STRING}
})

export default BlogModel