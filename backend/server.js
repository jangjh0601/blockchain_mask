const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const contract = require('./contract_test');
const etherscan = require('./etherscan');

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

app.get('/', function(req, res){
    res.send("welcome");
})
//app.get('/send', contract.sendTransfer);
app.get('/maskMaking/:Id/:Supply', contract.MaskMaking); //마스크 생산, 
app.get('/getMaskInfo/:maskNum', contract.getMaskInfo);

app.get('/normalTx/:address', etherscan.normalTx); //트랜잭션조회
app.get('/tokenInfo/:address', etherscan.getTokenInfofromWallet);//지갑주소의 토큰거래내역 조회


/*
#contract
maskMaking => 마스크생산
getMaksInfo => 마스크 구조체 정보, 파라미터 : 마스크번호

#etherscan
normalTx => 지갑 트랜잭션조회, 파라미터 : 지갑주소
tokenInfo => 지갑에 해당하는 토큰 트랜잭션들 조회, 파라미터 : 지갑주소

================= deprecated ==================
app.get('/checkwallet/:address', etherscan.checkwallet)
app.get('/internalTx:address', etherscan.internalTx)
*/


const server = app.listen(8000, function(){
    console.log('load Success!');
});