//mask Management

const request = require('request');
const util = require('util');


const myApi = 'DI2QYXMJ7U1UY4G8AAE175TC33B3V3SGSE';
const contractaddress = "0x6c28197b05a41145e35eb44e3e05b326095ba1d6";

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

exports.getMakerHistory = function(req, res){ //제조사 생성내역, 거래내역 조회
    let url = util.format('https://api-ropsten.etherscan.io/api?module=account&action=tokennfttx&contractaddress=%s&address=%s&page=1&offset=100&sort=asc&apikey=%s', contractaddress, req.params.address, myApi);
    request(url, function(err, response, body){
        if(!err && response.statusCode == 200){
            let json = JSON.parse(body);
            let result = json['result'];

            let total = new Object();
            let create = new Array();
            let deal = new Array();
            for(let tmp in result){
                //console.log('now : ' + tmp + ', ' + result[tmp]['to']);
                if(result[tmp]['to'] == req.params.address.toLowerCase()){ //생성내역, 지금은 거래완료한 토큰도 보이는방식, 거래한토큰은 거르는식으로 구현해야함.
                    let data = new Object();
                    data.time = result[tmp]['timeStamp'];
                    data.tokenId = result[tmp]['tokenID'];
                    data.num = '1';

                    create.push(data);
                }else{ //거래내역
                    let data = new Object();
                    data.time = result[tmp]['timeStamp'];
                    data.tokenId = result[tmp]['tokenID'];
                    data.num = '1';
                    data.maker = result[tmp]['from'];
                    data.dealer = result[tmp]['to'];

                    deal.push(data);
                }
            }
            total.createHistory = create;
            total.dealHistory = deal;
            res.send(JSON.stringify(total));
        }else{
            res.send('err' + body);
        };
    });
}
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