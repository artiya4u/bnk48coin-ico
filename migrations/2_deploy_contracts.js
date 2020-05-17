const BNK48CoinCrowdSale = artifacts.require("BNK48CoinCrowdSale");
const BNK48Coin = artifacts.require("BNK48Coin");

const Web3 = require('web3')

function ether(n) {
  return new Web3.utils.BN(Web3.utils.toWei(n, 'ether'));
}

module.exports = function (deployer, network, accounts) {
  const startTime = new Web3.utils.BN(Math.floor(new Date().getTime() / 1000)); // Now
  const endTime = new Web3.utils.BN(Math.floor(new Date(2020, 8, 8, 8, 8, 8, 0).getTime() / 1000)); // Sale Stop at 8 August 2020 @08:08:08
  const rate = new Web3.utils.BN(20000); // At 20,000 Token/ETH
  const wallet = accounts[0];
  const goal = ether('5000');
  const cap = ether('10000');

  let token, crowdsale;
  deployer.then(function () {
    return BNK48Coin.new({from: wallet});
  }).then(function (instance) {
    token = instance;
    return BNK48CoinCrowdSale.new(startTime, endTime, rate, wallet, cap, token.address, goal);
  }).then(function (instance) {
    crowdsale = instance;
    token.addMinter(crowdsale.address);
    console.log('Token address: ', token.address);
    console.log('Crowdsale address: ', crowdsale.address);
    return true;
  });
};