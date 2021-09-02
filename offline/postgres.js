console.log('PostgreSQL GET Connection');
var pg = require('pg');
var config  = require("./config");
var connectionString = {
        user: 'postgres',
        host: '192.168.5.240',
        database: 'test',
        password: 'password',
        port: 5432,
      };
module.exports = new pg.Pool(connectionString);
