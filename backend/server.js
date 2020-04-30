const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const contract = require('./contract_test');

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

app.get('/', function(req, res){
    res.send("welcome");
})
//app.get('/send', contract.sendTransfer);
app.get('/maskMaking/:Id/:Supply', contract.maskMaking); //마스크 생산, 
app.get('/getMaskInfo/:maskNum', contract.getMaskInfo);


const server = app.listen(8000, function(){
    console.log('load Success!');
});