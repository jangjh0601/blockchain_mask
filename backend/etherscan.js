//mask Management

const request = require('request');
const util = require('util');


const myApi = 'DI2QYXMJ7U1UY4G8AAE175TC33B3V3SGSE';
const contractaddress = '0x781964d811ab08e584f854572ebd2305c93a1c3f';

exports.normalTx = function(req, res){
    let url = util.format('http://api-ropsten.etherscan.io/api?module=account&action=txlist&address=%s&startblock=0&endblock=99999999&sort=asc&apikey=%s', req.params.address, myApi);
    console.log('start normalTx');
    request(url, function(err, response, body){
        if(!err && response.statusCode == 200){
            res.send('good' + body);
        }else{
            res.send('err' + body);
        };
    });
};

exports.getTokenInfofromWallet = function(req, res){
    let url = util.format('https://api-ropsten.etherscan.io/api?module=account&action=tokennfttx&contractaddress=%s&address=%s&page=1&offset=100&sort=asc&apikey=%s', contractaddress, req.params.address, myApi);
    request(url, function(err, response, body){
        if(!err && response.statusCode == 200){
            res.send('good' + body);
        }else{
            res.send('err' + body);
        };
    });
};

/*
#deprecated
exports.checkwallet = function(req, res){
    //Get a list of 'Normal' Transactions By Address
    let url = util.format('http://api-ropsten.etherscan.io/api?module=account&action=txlistinternal&address=%s&startblock=2700000&endblock=2702578&sort=asc&apikey=%s', req.params.address, myApi);
    console.log(url);
    request(url, function(err, response, body){
        if(!err && response.statusCode == 200){
            //console.log(body);
            res.send('good' + body);
        }else{
            //console.log(body);
            res.send('err' + body);
        }
    });
};

exports.internalTx = function(req, res){//지금작동안함싸발
    let url = util.format('http://api-ropsten.etherscan.io/api?module=account&action=txlistinternal&address=%s&startblock=0&endblock=2702578&sort=asc&apikey=%s', req.params.address, myApi);
    console.log('start internalTx');
    request(url, function(err, response, body){
        if(!err && response.statusCode == 200){
            res.send('good' + body);
        }else{
            res.send('err' + body);
        };
    });
};
*/