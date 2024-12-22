    const mongoose = require("mongoose");

    const connectDb = async()=>{
        try{
            const mongoUri = process.env.MONGO_BASE_URI ;
            options = {
                user: process.env.MONGO_USERNAME,
                pass: process.env.MONGO_PASSWORD,
                dbName: process.env.DB_NAME,
            };      

            const connect = await mongoose.connect(mongoUri, options);

            console.log("Database connected:",connect.connection.name)
            // console.log("Database connected:",process.env.DB_NAME)
        }catch(err){
            console.error("Database connection error:", err);
            console.log("Attempting to connect to database at:", process.env.MONGO_BASE_URI);

            process.exit(1);
        }
    };

    module.exports = connectDb;
