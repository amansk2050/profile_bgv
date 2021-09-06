console.log("PostgreSQL GET Connection");
var pg = require("pg");
var connectionString = {
  user: "postgres",
  host: "18.157.69.103",
  database: "code5portal",
  password: "password",
  port: 5432,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000
};

// var connectionString = {
//   user: process.env.user,
//   host: process.env.host_permission,
//   database: process.env.database_permission,
//   password: process.env.password_permission,
//   port: process.env.port_permission,
// };
module.exports = new pg.Pool(connectionString);
