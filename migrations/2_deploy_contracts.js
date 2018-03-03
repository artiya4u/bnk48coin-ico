const BNK48CoinCrowdSale = artifacts.require("BNK48CoinCrowdSale");
const BNK48Coin = artifacts.require("BNK48Coin");
const RefundVault = artifacts.require("RefundVault");

function ether(n) {
    return new web3.BigNumber(web3.toWei(n, 'ether'));
}

module.exports = function (deployer, network, accounts) {
    const startTime = new web3.BigNumber(Math.floor(new Date().getTime() / 1000)); // Now
    const endTime = new web3.BigNumber(Math.floor(new Date(2018, 8, 8, 8, 8, 8, 0).getTime() / 1000)); // Sale Stop at 8 August 2018 @08:08:08
    const rate = new web3.BigNumber(20000); // At 20,000 Token/ETH
    const wallet = accounts[0];
    const goal = ether(5000);
    const cap = ether(10000);

    let token, vault, crowdsale;
    deployer.then(function () {
        return BNK48Coin.new({from: wallet});
    }).then(function (instance) {
        token = instance;
        return RefundVault.new(wallet, {from: wallet});
    }).then(function (instance) {
        vault = instance;
        return BNK48CoinCrowdSale.new(startTime, endTime, rate, wallet, cap, token.address, goal);
    }).then(function (instance) {
        crowdsale = instance;
        token.transferOwnership(crowdsale.address);
        vault.transferOwnership(crowdsale.address);
        console.log('Token address: ', token.address);
        console.log('Crowdsale address: ', crowdsale.address);
        return true;
    });
};
