      //
      // window.addEventListener('load', function () {
      //     if (typeof web3 !== 'undefined') {
      //         console.log('Web3 Detected! ' + web3.currentProvider.constructor.name);
      //         window.web3 = new Web3(web3.currentProvider);
      //     } else {
      //         console.log('No Web3 Detected... using HTTP Provider');
      //         window.web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/6d989b9558914d02a9513a3433b8cd84"));
      //     }
      // });

    var web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/6d989b9558914d02a9513a3433b8cd84"));
//     web3.eth.getBalance('0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB', (err, data)=> {
//     console.log(err);
//     console.log(data);
// });
