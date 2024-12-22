const asyncHandler = require("express-async-handler");
const History = require("../models/historyModel")
const { validationResult } = require("express-validator");
const OS = require('os');



const getHistories = asyncHandler( async (req,res) => {
        const histories = await History.find();
        console.log(res)
        res.status(200).json(histories);
});

const liveStatus = asyncHandler( async (req,res) => {
    console.log("Live Status endpoint hit");
    res.setHeader('Content-Type', 'application/json');
    res.send({
        status: "live"
    });
});

const os = asyncHandler( async (req,res) => {
    console.log("Os endpoint hit");
    res.setHeader('Content-Type', 'application/json');
    res.send({
        "os": OS.hostname(),
        "env": process.env.NODE_ENV
    });
    
});

const createHistory = asyncHandler( async (req,res) => {
    console.log("The request body is:", req.body);
    const {type, resultText, full_url} = req.body; // {Type: yerg, Number: sdsf}
    const result = validationResult(req);
    if (!result.isEmpty()) {
        console.log("Validation errors:", result.array()); // Print validation errors
        res.status(400);
        throw new Error("You should respect the specifications !");
    } 
    // const history = await History.create({
    //     type,
    //     resultText,
    //     full_url,
    // });
    // res.status(201).json(history);
    try {
        const history = await History.create({ type, resultText, full_url });
        res.status(201).json(history);
    } catch (error) {
        res.status(500);
        // Ensure you throw the error to reach the error handler
        throw new Error("Database error");
    }
});


// const getHistory =  asyncHandler( async (req,res) => {
//     const history = await History.findById(req.params.id);
//     if(!history){
//         res.status(404);
//         throw new Error("History not found")
//     }
//     res.status(201).json(history);
// });

// const updateHistory = asyncHandler( async (req,res) => {
//     const history = await History.findById(req.params.id);
//     if(!history){
//         res.status(404);
//         throw new error("History not found");
//     }
//     const updatedHistory = await History.findByIdAndUpdate(
//         req.params.id,
//         req.body,
//         { new: true }
//     );
//     res.status(200).json(updatedHistory);
// });

// const deleteHistory = asyncHandler(async (req, res) => {
//     const history = await History.findById(req.params.id);
//     if (!history) {
//         res.status(404);
//         throw new Error("History not found");
//     }
//     await History.findByIdAndDelete(req.params.id);
//     res.status(200).json(history);
// });
module.exports = { getHistories, createHistory, liveStatus, os};
