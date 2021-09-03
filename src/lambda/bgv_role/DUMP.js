///// ...................................... start default setup ............................................////
let mode, sns, dynamodb, docClient, S3;
const AWS = require("aws-sdk");
const response = require("./lib/response.js");

if (process.env.AWS_REGION == "local") {
  mode = "offline";
} else {
  mode = "online";
}
///// ...................................... end default setup ............................................////

/**
 * modules list
 */
/**
 * This is the Promise caller which will call each and every function based
 * @param  {[type]}   data     [content to manipulate the data]
 * @param  {Function} callback [need to send response with]
 * @return {[type]}            [description]
 */
function execute(data, callback) {
  console.log(data);
  response({ code: 404, err: { err: "Page Not Found" } }, callback);
}
/**
 * last line of code
 * @json {main_object}
 */
module.exports = { execute };
