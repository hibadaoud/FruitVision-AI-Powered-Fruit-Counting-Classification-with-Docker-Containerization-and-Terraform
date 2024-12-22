const mongoose = require("mongoose");

const historySchema = mongoose.Schema({
    type: {
        type: String,
        required: [true, "Please add the type of fruits"],
    },
    resultText: {
        type: String,
        required: [true, "Please add the resultText of fruits"],
    },
    full_url:{
        type: String,
    },
},
{
    timestamps: true,

});

module.exports = mongoose.model("History", historySchema);
