const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const contract = require('./contract_test');

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

app.get('/', function(req, res){
    res.send("welcome");
})
app.get('/send', contract.sendTransfer);

const server = app.listen(8000, function(){
    console.log('load Success!');
});