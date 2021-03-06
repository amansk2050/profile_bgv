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
    },
    role_id:{
      type:"number"
    },
    status:{
      type:"boolean"
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
      return updateRole(result);
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


//----------fucntion to update role --

function updateRole(result) {
  console.log("inside updateRole function ");
  return new Promise(async (resolve, reject) => {
    var set1 = [];
    var count1 = 0;
    var query = "";
    try {
      query += `update bgv_role `;
      if (result != null) {
        if (
          result.role_name != undefined ||
          result.status != undefined 
        ) {
          query += "set ";

          if (result.role_name) {
            set1[count1] = `role_name = '${result.role_name}'  `;
            count1++;
          }
          
          
          if (result.status) {
            set1[count1] = `status = '${result.status}'  `;
            count1++;
          }

          query += set1.join(" , ");
        }
      }
      query += `where role_id='${result.role_id}';`;
      let res = await client.query(query);
      resolve({ message: "role updated successfully" });
    } catch (err) {
      reject(err);
    }
    finally {
      client.release(true);
    }
  });
}
