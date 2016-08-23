const DDApi = require("./index.js");

DDApi.init("", "");

DDApi.crafts.getAll((data) => {
	console.log(data);
});