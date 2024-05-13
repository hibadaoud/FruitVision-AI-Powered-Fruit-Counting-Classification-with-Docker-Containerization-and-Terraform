const cors = require('cors')
const express = require('express');
const connectDb = require("./config/dbConnection");
const dotenv = require('dotenv').config();
const historyRoutes = require('./routes/historyRoutes');
const errorHandler = require('./middleware/errorHandler');

connectDb();
const app = express();
const port = process.env.PORT || 5000;

app.use(cors())

app.use(express.json());
app.use("/api/history", require("./routes/historyRoutes"));
app.use(errorHandler);

app.listen(port, '0.0.0.0', () => {
    console.log(`Server running on port ${port}`);
})