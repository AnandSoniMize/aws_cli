//redshift.js
var Redshift = require('node-redshift');
var logger = require('tracer').colorConsole();

var client = {
  user: "adminuser",
  database: "database1",
  password: "TopSecret1",
  port: 5339,
  host: "mycluster.ckjlpf2bivsj.us-east-2.redshift.amazonaws.com",
};

console.info("creating redshift connection with client", client);
// The values passed in to the options object will be the difference between a connection pool and raw connection
var redshift = new Redshift(client, {rawConnection: true});
logger.info("making a query");
redshift.rawQuery(`SELECT * FROM "Tags"`, {raw: true})
    .then(function(data){
        console.log(data);
    })
    .catch(function(err){
        console.log(err);
    });