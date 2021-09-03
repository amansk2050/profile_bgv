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
    
    role_id:{
      type:"number"
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
      return getRole(result);
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


//----------getting role ---------

function getRole(result) {
  console.log("inside getRole");
  return new Promise(async (resolve, reject) => {
    try {
      var where1 = [];
      var count1 = 0;
      var query = "";
      query += `select role_id,role_name,status from bgv_role `;
      if (result != null) {
        if (result.role_id || result.status || result.role_name) {
          query += "WHERE ";

          if (result.role_id != undefined) {
            where1[count1] = `role_id IN (${result.role_id})  `;
            count1++;
          }

          if (result.role_name != undefined) {
            where1[count1] = `lower(role_name) like lower('%${result.role_name}%')  `;
            count1++;
          }

          if (result.status) {
            where1[count1] = `status = '${result.status}' `;
            count1++;
          }
          query += where1.join(" AND ");
        }
        if (result.page) {
          result.page = JSON.parse(result.page);
        } else {
          result["page"] = 1;
        }
      }
      check = query
      query += `;`;
      query1 = check + `order by role_name offset ${(result.page - 1) * 20} limit 20;`;
      console.log("----------", query1);
      let res = await client.query(query1);
      
      let res1 = await client.query(query);
      if (res1.rowCount > 0) {
        resolve({ count: res.rowCount, data: res.rows, totalCount: res1.rows.length });
      }
      else {
        resolve({ count: res.rowCount, data: res.rows, totalCount: 0 });
      }
    } catch (err) {
      reject(err);
    }
    finally {
      client.release(true);
    }
  });
}


