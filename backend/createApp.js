const cors = require('cors')
const express = require('express');
const errorHandler = require('./middleware/errorHandler');

function createApp() {
    const app = express();

    app.use(cors())

    app.use(express.json());
    
    app.use("/nodejs/api/history", require("./routes/historyRoutes"));
    app.use(errorHandler);

    return app
}
module.exports = createApp;
