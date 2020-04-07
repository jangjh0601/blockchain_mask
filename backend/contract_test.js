const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7546"));


let contractAbi = [
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"type": "function",
		"stateMutability": "view"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_to",
				"type": "address"
			},
			{
				"name": "_value",
				"type": "uint256"
			}
		],
		"name": "transfer",
		"outputs": [],
		"payable": false,
		"type": "function",
		"stateMutability": "nonpayable"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_account",
				"type": "address"
			}
		],
		"name": "getBalance",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"type": "function",
		"stateMutability": "view"
	},
	{
		"inputs": [
			{
				"name": "initialSupply",
				"type": "uint256"
			}
		],
		"payable": false,
		"type": "constructor",
		"stateMutability": "nonpayable"
	}
];

let contractAddress = "0x26f820bb2e13dc64996a4ddc23f7b6e110e31623";
let fromAddress = "0xf7ae4a72de695e3e1afff12b53585807bf0bbe57";
let contract = new web3.eth.Contract(contractAbi, contractAddress);
//let private = "4d4b6e3ff68e2287296c124b1b620268eadad3c7269cb086a00d8ec8948d92d2";
//contract.methods.getBalance(fromAddress).call().then(console.log);

/*
contract.methods.transfer("0xaaa61aa05a9df70eae8e9dba9161825ea1e52dd2","1")
.send({from : "0xf7ae4a72de695e3e1afff12b53585807bf0bbe57"}, function(err, result){
	if(err){
		console.log(err);
	}else{
		console.log(result);
	}
});
*/

exports.sendTransfer = function(req, res){
	try{
		contract.methods.transfer("0xaaa61aa05a9df70eae8e9dba9161825ea1e52dd2","1")
		.send({from : "0xf7ae4a72de695e3e1afff12b53585807bf0bbe57"}, function(err, result){
			if(err){
				res.send(err);
			}else{
				res.send(result);
			}
		});
	}catch{
		res.send("error");
	}
}

/* deprecated
let tx_builder = contract.methods.transfer("0xaaa61aa05a9df70eae8e9dba9161825ea1e52dd2","1");
let encoded_tx = tx_builder.encodeABI();
let transactionObject = {
    gas: 23064,
    data: encoded_tx,
    from: fromAddress,
    to:contractAddress
};

web3.eth.accounts.signTransaction(transactionObject, private, function(err, signedTx){
    if(err){
        console.log(err);
    }else{
        web3.eth.sendSignedTransaction(signedTx.rawTransaction)
        .on('receipt',function(err,result){
            if(err){
                console.log(err);
            }else{
                console.log(result);
            }
        });
    }
});
*/
