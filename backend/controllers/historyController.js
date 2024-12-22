const asyncHandler = require("express-async-handler");
const History = require("../models/historyModel")
const getHistories = asyncHandler( async (req,res) => {
    const histories = await History.find();
    console.log(res)
    res.status(200).json(histories);
});


const createHistory = asyncHandler( async (req,res) => {
    console.log("The request body is:", req.body);
    const {type, resultText, full_url} = req.body; // {Type: yerg, Number: sdsf}
    if (!type || !resultText || !full_url){
        res.status(400);
        throw new Error("All fiels is mandatory !");
    } 
    const history = await History.create({
        type,
        resultText,
        full_url,
    });
    res.status(201).json(history);
});

const getHistory =  asyncHandler( async (req,res) => {
    const history = await History.findById(req.params.id);
    if(!history){
        res.status(404);
        throw new Error("History not found")
    }
    res.status(201).json(history);
});

const updateHistory = asyncHandler( async (req,res) => {
    const history = await History.findById(req.params.id);
    if(!history){
        res.status(404);
        throw new error("History not found");
    }
    const updatedHistory = await History.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true }
    );
    res.status(200).json(updatedHistory);
});

const deleteHistory = asyncHandler(async (req, res) => {
    const history = await History.findById(req.params.id);
    if (!history) {
        res.status(404);
        throw new Error("History not found");
    }
    await History.findByIdAndDelete(req.params.id);
    res.status(200).json(history);
});
module.exports = { getHistories, createHistory, getHistory, updateHistory, deleteHistory, };