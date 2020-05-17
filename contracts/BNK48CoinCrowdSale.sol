pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/RefundableCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract BNK48CoinCrowdSale is CappedCrowdsale, RefundableCrowdsale, MintedCrowdsale
{

    constructor(uint256 _openingTime, uint256 _closingTime, uint256 _rate, address payable _wallet, uint256 _cap, IERC20 _token, uint256 _goal) public
    Crowdsale(_rate, _wallet, _token)
    CappedCrowdsale(_cap)
    TimedCrowdsale(_openingTime, _closingTime)
    RefundableCrowdsale(_goal)
    {
        require(_goal <= _cap);
    }
}