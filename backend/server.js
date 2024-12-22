const connectDb = require("./config/dbConnection");
const dotenv = require('dotenv').config();
const createApp = require("./createApp");


connectDb();

const app = createApp();
const port = process.env.PORT || 5000;

app.listen(port, '0.0.0.0', () => {
    console.log(`Server running on port ${port}`);
})  