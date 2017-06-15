var express = require('express');
var app = express();

var bodyParser = require('body-parser')
app.use(bodyParser.json());





var mongo = require('mongodb');
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/mongo";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  console.log("Database created!");
  db.close();
});

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  db.createCollection("sample", function(err, res) {
    if (err) throw err;
    console.log("Table created!");
    db.close();
  });
});

var object = [];


MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  db.collection("sample").find({}).toArray(function(err, result) {
    if (err) throw err;
    object = result;
    console.log(result);
    db.close();
  });
});

app.get('/', function (req, res) {
   res.send(object);
})

app.post('/', function (req, res) {
    res.send('Hello World');
    MongoClient.connect(url, function(err, db) {
      if (err) throw err;
      var myobj = req.body;
      db.collection("sample").insertOne(myobj, function(err, res) {
        if (err) throw err;
        console.log("1 record inserted");
        db.close();
      });
    });
    console.log(req.body);
})



var jsonString = "{\"key\":\"value\"}";
var jsonObj = JSON.parse(jsonString);
console.log(jsonObj.key);

var server = app.listen(3000, function () {
   var host = server.address().address
   var port = server.address().port

   console.log("Example app listening at http://%s:%s", host, port)
})
