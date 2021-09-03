const response = require("./lib/response.js");
const Ajv = require("ajv");
const ajv = new Ajv.default();
const con = require("./lib/conf/postgres");
///// ...................................... end default setup ............................................////

const postSchema = {
  $async: true,
  type: "object",
  additionalProperties: false,
  properties: {
    role_name: {
      type: "string"
    }

  }
};

var validate1 = ajv.compile(postSchema);
module.exports = { execute };
/**
 * This is the Promise caller which will call each and every function based
 * @param  {[type]}   data    [content to manipulate the data]
 * @param  {Function} callback [need to send response with]
 * @return {[type]}            [description]
 */
async function execute(data, headers, callback) {
  client = await con.connect();
  if (typeof data == "string") {
    data = JSON.parse(data);
  }
  validate_all(validate1, data)
    
    .then(function (result) {
      return insertRole(result);
    })
    .then(function (result) {
      response({ code: 200, body: result }, callback);
    })
    .catch(function (err) {
      console.log(err);
      response({ code: 400, err: { err } }, callback);
    });
}
/**
 * validate the data to the categories
 * @param  {[type]} data [description]
 * @return {[type]}      [description]
 */
function validate_all(validate, data) {
  return new Promise((resolve, reject) => {
    validate(data)
      .then(function (res) {
        resolve(res);
      })
      .catch(function (err) {
        reject(err.errors[0].dataPath + " " + err.errors[0].message);
      });
  });
}


//----------fucntion to insert role --
function insertRole(result) {
  console.log("inside insertRole function ");
  return new Promise(async (resolve, reject) => {
    try {
      if (typeof result == "string") {
        result = JSON.parse(result);
      }

      var query = `insert into bgv_role(role_name) values('${result.role_name}') returning role_id;`;

      let res = await client.query(query);

      role_id = res.rows[0].role_id;

      console.log('course_id------->', role_id);

      resolve({ success: "role  added successfuly" });
    } catch (err) {
      reject(err);
    }
    finally {
      client.release(true);
    }
  });
}
