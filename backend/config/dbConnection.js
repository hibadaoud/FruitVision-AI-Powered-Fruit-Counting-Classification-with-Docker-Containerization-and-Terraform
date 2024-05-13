const mongoose = require("mongoose");
const connectDb = async()=>{
    try{
        const connect = await mongoose.connect(process.env.DB_URI, {dbName: process.env.DB_NAME});
        console.log("Database connected:",connect.connection.name)
    }catch(err){
        console.error("Database connection error:", err);
        console.log("Attempting to connect to database at:", process.env.DB_URI);

        process.exit(1);
    }
};
module.exports = connectDb;
// const mongoose = require("mongoose");

// const connectDb = async() => {
//     const uri = process.env.DB_URI || "mongodb://mongo:supspace1@mongo:27017/fruit-vision?authSource=admin";
//     try {
//         // Utilisation des options pour gérer les avertissements dépréciés
//         const connect = await mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });
//         console.log("Database connected:", connect.connection.name);
//     } catch (err) {
//         console.error("Database connection error:", err);
//         process.exit(1);
//     }
// };

// module.exports = connectDb;
// const mongoose = require("mongoose");

// const connectDb = async() => {
//     const uri = process.env.DB_URI || "mongodb://mongo:supspace1@mongo:27017/fruit-vision?authSource=admin";
//     try {
//         // Connectez-vous sans utiliser d'options obsolètes
//         const connect = await mongoose.connect(uri);
//         console.log("Database connected:", connect.connection.name);
//     } catch (err) {
//         console.error("Database connection error:", err);
//         process.exit(1);
//     }
// };

// module.exports = connectDb;

