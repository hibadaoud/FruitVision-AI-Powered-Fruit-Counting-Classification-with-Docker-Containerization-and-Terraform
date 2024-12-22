const createHistoryValidationSchema = {
	type: {
		notEmpty: {
			errorMessage: "type cannot be empty",
		},
		isString: {
			errorMessage: "type must be a string!",
		},
	},
	resultText: {
        notEmpty: {
			errorMessage: "resultText cannot be empty",
		},
        isString: {
			errorMessage: "resultText must be a string!",
		},
	},
	full_url: {
        notEmpty: {
			errorMessage: "full_url cannot be empty",
		},
        isString: {
			errorMessage: "full_url must be a string!",
		},
	},
};

module.exports = createHistoryValidationSchema;
