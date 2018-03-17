App = {
  web3Provider: null,
  contracts: {},
  tokenAddress: null,

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    // Initialize web3 and set the provider to the testRPC.
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // set the provider you want from Web3.providers
      App.web3Provider = new Web3.providers.HttpProvider('https://ropsten.infura.io/oA8X2g76MMUVqglwqhCq');
      web3 = new Web3(App.web3Provider);
    }

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('contracts/FaceCoinCrowdsale.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract.
      var CrowdsaleArtifact = data;
      App.contracts.Crowdsale = TruffleContract(CrowdsaleArtifact);

      // Set the provider for our contract.
      App.contracts.Crowdsale.setProvider(App.web3Provider);

      web3.eth.getBlock("latest",(err,block)=>{
        console.log('gasLimit',block.gasLimit)
        let gasLimit = block.gasLimit;
        web3.eth.getGasPrice((err,price)=>{
          console.log('gasPrice',price.c[0])
          App.contracts.Crowdsale.defaults({
            gas: gasLimit,
            gasPrice: price.c[0],
          });
          App.contracts.Crowdsale.deployed().then(function(instance) {
            crowdsaleInstance = instance;

            return crowdsaleInstance.tokenReward();
          }).then(function(tokenAddress){
            console.log(tokenAddress);
            App.tokenAddress = tokenAddress;
            return App.initCoin();
          }).catch(function(err) {
            console.log(err.message);
          });
        });
      });
    });
  },

  initCoin: function() {
    $.getJSON('contracts/FaceCoin.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract.
      var FaceCoinArtifact = data;
      App.contracts.FaceCoin = TruffleContract(FaceCoinArtifact);

      // Set the provider for our contract.
      App.contracts.FaceCoin.setProvider(App.web3Provider);

      // Use our contract to retieve and mark the adopted pets.
      return App.getBalances();
    });

    return true;
  },


  handleSendTransaction: function(amount) {
    console.log('Buying ' + amount);

    var crowdsaleInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Crowdsale.deployed().then(function(instance) {
        crowdsaleInstance = instance;

        return crowdsaleInstance.sendTransaction({ from: account, value: web3.toWei(amount/1000, "ether")});
      }).then(function(result) {
        alert('Transfer Successful!');
        return App.getBalances();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  getBalances: function() {
    console.log('Getting balances...');

    var crowdsaleInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      faceCoinInstance = App.contracts.FaceCoin.at(App.tokenAddress);

      faceCoinInstance.balanceOf(account).then(function(result) {
        console.log('balance', result);
        $('#possession').text(web3.fromWei(result.toNumber(), "ether"));
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    if (typeof web3 === 'undefined') {
      $('#warning').show();
      return false;
    }
    var account = web3.eth.accounts[0];
    if (!account) {
      $('#warning').show();
      var accountInterval = setInterval(function() {
        if (web3.eth.accounts[0] !== account) {
          account = web3.eth.accounts[0];
          $('#warning').hide();
          App.init();
        }
      }, 100);
    } else {
      App.init();
    }
  });
});

var elmApp = Elm.Main.fullscreen();

elmApp.ports.buyToken.subscribe(function(amount) {
    console.log("Buy Token")
    App.handleSendTransaction(amount)
    //app.ports.suggestions.send(suggestions);
});
