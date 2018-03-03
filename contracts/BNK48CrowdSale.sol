pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "zeppelin-solidity/contracts/crowdsale/distribution/RefundableCrowdsale.sol";
import "zeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract BNK48CoinCrowdSale is CappedCrowdsale, RefundableCrowdsale, MintedCrowdsale {

    function BNK48CoinCrowdSale(uint256 _openingTime, uint256 _closingTime, uint256 _rate,
        address _wallet, uint256 _cap, MintableToken _token, uint256 _goal) public
    Crowdsale(_rate, _wallet, _token)
    CappedCrowdsale(_cap)
    TimedCrowdsale(_openingTime, _closingTime)
    RefundableCrowdsale(_goal)
    {
        require(_goal <= _cap);
    }
}
