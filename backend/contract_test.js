/*
getMaskInfo -> 마스크번호 넣고, 정보가져오기
MaskMaking -> 지갑주소, privateKey 
*/

var firebaseConfig = {
    apiKey: "AIzaSyBUFarAIUCHFdR-pIrYGaTNJC43CpFBZZA",
    authDomain: "maskproject-6e385.firebaseapp.com",
    databaseURL: "https://maskproject-6e385.firebaseio.com",
    projectId: "maskproject-6e385",
    storageBucket: "maskproject-6e385.appspot.com",
    messagingSenderId: "759315784284",
    appId: "1:759315784284:web:f7c963bac46cd7798cbc99",
    measurementId: "G-B4436TDC82"
  };

const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.WebsocketProvider('wss://ropsten.infura.io/ws/v3/df0ff335a16c463d96038903ff43987e'));
const fb = require('firebase');

fb.initializeApp(firebaseConfig);

let Tx = require('ethereumjs-tx').Transaction;
//https://ropsten.infura.io/v3/df0ff335a16c463d96038903ff43987e

let contractAbi = [
	{
		"inputs": [],
		"name": "_maskMaking",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_key",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_value",
				"type": "uint256"
			}
		],
		"name": "add",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "approve",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_tokenId",
				"type": "uint256"
			}
		],
		"name": "burnToken",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_tokenId",
				"type": "uint256"
			}
		],
		"name": "dealMasks",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "safeTransferFrom",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			},
			{
				"internalType": "bytes",
				"name": "_data",
				"type": "bytes"
			}
		],
		"name": "safeTransferFrom",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "approved",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "Approval",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "operator",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "bool",
				"name": "approved",
				"type": "bool"
			}
		],
		"name": "ApprovalForAll",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "_from",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "_to",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "_tokenId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "_Message",
				"type": "string"
			}
		],
		"name": "DealEvent",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "_from",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "_tokenId",
				"type": "uint256"
			}
		],
		"name": "Illegal",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "_account",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "_Message",
				"type": "string"
			}
		],
		"name": "Makemask",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "_from",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "_tokenId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "_Message",
				"type": "string"
			}
		],
		"name": "SellEvent",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_collect",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_tokenId",
				"type": "uint256"
			}
		],
		"name": "sellMasks",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "operator",
				"type": "address"
			},
			{
				"internalType": "bool",
				"name": "approved",
				"type": "bool"
			}
		],
		"name": "setApprovalForAll",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "Transfer",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "transferFrom",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "baseURI",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_key",
				"type": "address"
			}
		],
		"name": "contains",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "getApproved",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_key",
				"type": "address"
			}
		],
		"name": "getByKey",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "operator",
				"type": "address"
			}
		],
		"name": "isApprovedForAll",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "Masks",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "ownerOf",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes4",
				"name": "interfaceId",
				"type": "bytes4"
			}
		],
		"name": "supportsInterface",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			}
		],
		"name": "tokenByIndex",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			}
		],
		"name": "tokenOfOwnerByIndex",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "tokenURI",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalSupply",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

let contractAddress = "0x6c28197b05a41145e35eb44e3e05b326095ba1d6";

const contract = new web3.eth.Contract(contractAbi, contractAddress);
//const pk = Buffer.from('7D88DB82FA83B7A1418FEB4A291496E0D72DDD08E8D15162B666A12043EC6F67', 'hex');

exports.getMaskInfo = async function(req, res){
   let maskNum = req.params.maskNum;
   try{
      const result = await contract.methods.Masks(maskNum).call();
      console.log(result);
      res.send(result);
   }catch(err){
      res.send("error");
   }
};

exports.MaskMaking = function(req, res){ // param : uid
	let uid = req.params.uid;
	let db = fb.firestore();
	console.log('uid: ' + uid);

	let usersRef = db.collection("users").doc(uid);

	usersRef.get().then(doc => {
		if(!doc.exists){
			console.log('Uid is not matched');
		}else{
			let account = doc.data().addr;
			let privatekey = doc.data().privateKey;

			const pk = Buffer.from(privatekey,'hex');

			web3.eth.getTransactionCount(account, (err, txCount) =>{

				const txObject = {
					nonce: web3.utils.toHex(txCount),
					to: contractAddress,
					//value: web3.utils.toHex(web3.utils.toWei('0', 'ether')),
					gasLimit: web3.utils.toHex(2100000),
					gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
					data: contract.methods._maskMaking().encodeABI()
				};
			
				const tx = new Tx(txObject, {'chain':'ropsten'});
				tx.sign(pk);
			
				const serializedTx = tx.serialize();
				const raw = '0x' + serializedTx.toString('hex');
			
				web3.eth.sendSignedTransaction(raw)
					.once('transactionHash', (hash) => {
						res.send('transactionHash: https://roptsten.etherscan.io/tx/' + hash);
					})
					.on('error', console.error);
			});
		}
	}).catch((err)=>{
		console.log('Error', err);
	})
   
}

exports.dealMasks = function(req, res){ //param: sender uid, receiver address, tokenId
	let send_uid = req.params.send_uid;
	let recv_addr = req.params.recv_addr;
	let token_Id = req.params.token_id;
	let db = fb.firestore();
	console.log(token_Id);
	let usersRef = db.collection("users").doc(send_uid);

	usersRef.get().then(doc => {
		let account = doc.data().addr;
		let privatekey = doc.data().privateKey;

		const pk = Buffer.from(privatekey,'hex');

		web3.eth.getTransactionCount(account, (err, txCount) =>{

			const txObject = {
				nonce: web3.utils.toHex(txCount),
				to: contractAddress,
				//value: web3.utils.toHex(web3.utils.toWei('0', 'ether')),
				gasLimit: web3.utils.toHex(2100000),
				gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
				data: contract.methods.dealMasks(recv_addr, token_Id).encodeABI()
			};
		
			const tx = new Tx(txObject, {'chain':'ropsten'});
			tx.sign(pk);
		
			const serializedTx = tx.serialize();
			const raw = '0x' + serializedTx.toString('hex');
		
			web3.eth.sendSignedTransaction(raw)
				.once('transactionHash', (hash) => {
					console.log('transactionHash: https://roptsten.etherscan.io/tx/' + hash);
				})
				.on('error', console.error);
		});
	});
}
/*
async function dealMasks(from, privateKey, to, tokenId) {
    const pk = Buffer.from(privateKey,'hex');

	web3.eth.getTransactionCount(from, (err, txCount) =>{

		const txObject = {
			nonce: web3.utils.toHex(txCount),
			to: contractAddress,
			//value: web3.utils.toHex(web3.utils.toWei('0', 'ether')),
			gasLimit: web3.utils.toHex(2100000),
			gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
			data: contract.methods.dealMasks(from, to, tokenId).encodeABI()
		};
	
		const tx = new Tx(txObject, {'chain':'ropsten'});
		tx.sign(pk);
	
		const serializedTx = tx.serialize();
		const raw = '0x' + serializedTx.toString('hex');
	
		web3.eth.sendSignedTransaction(raw)
			.once('transactionHash', (hash) => {
				console.log('transactionHash https://roptsten.etherscan.io/tx/' + hash);
			//})
			//.once('receipt', (receipt) =>{
			//	console.log('receipt' + receipt.getLogs().get(0).getTopics().get(0));
			}).on('error', console.error);
	});
}
*/
//MaskMaking('maker A', '0xc2988556Ae24daF3A20B16d3EB4D970E43e3546D', '7D88DB82FA83B7A1418FEB4A291496E0D72DDD08E8D15162B666A12043EC6F67');
//dealMasks('0xc2988556Ae24daF3A20B16d3EB4D970E43e3546D', '7D88DB82FA83B7A1418FEB4A291496E0D72DDD08E8D15162B666A12043EC6F67', '0xb93428830a28aD774DB9A3937fC8962fb4429785', '2')