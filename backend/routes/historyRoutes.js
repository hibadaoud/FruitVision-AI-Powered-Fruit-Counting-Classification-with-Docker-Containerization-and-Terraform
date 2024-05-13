const express = require('express');
const router = express.Router();
const { getHistories, createHistory, getHistory, updateHistory, deleteHistory, } = require("../controllers/historyController");

router.route("/").get(getHistories).post(createHistory);
router.route("/:id").get(getHistory).put(updateHistory).delete(deleteHistory);

module.exports = router;
