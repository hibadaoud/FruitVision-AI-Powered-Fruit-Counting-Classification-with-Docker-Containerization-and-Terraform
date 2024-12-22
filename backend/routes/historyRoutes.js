const express = require('express');
const router = express.Router();
const { checkSchema } = require("express-validator");
const { getHistories, createHistory,liveStatus, os} = require("../controllers/historyController");
const createHistoryValidationSchema = require("../utils/validationSchemas");

router.route("/").get(getHistories).post(checkSchema(createHistoryValidationSchema),createHistory);
console.log("History routes loaded");

router.route("/live").get(liveStatus);
router.route("/os").get(os);

// router.route("/:id").get(getHistory).put(updateHistory).delete(deleteHistory);

module.exports = router;
