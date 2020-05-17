pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";


contract Subscription is Ownable {
    using SafeMath for uint256;

    /// @dev The token being use
    IERC20 public token;

    /// @dev Address where fee are collected
    address public wallet;

    /// @dev Cost per day of membership
    uint256 public subscriptionRate;

    mapping(uint256 => uint256) subscriptionExpiration;

    /**
     * Event for subscription purchase logging
     * @param purchaser who paid for the subscription
     * @param userId user id who will benefit from purchase
     * @param day day of subscription purchased
     * @param amount amount of subscription purchased in wei
     * @param expiration expiration of user subscription.
     */
    event SubscriptionPurchase(
        address indexed purchaser,
        uint256 indexed userId,
        uint256 day,
        uint256 amount,
        uint256 expiration
    );

    constructor(
        uint256 _rate,
        address _fundWallet,
        IERC20 _token) public
    {
        require(address(_token) != address(0));
        require(_fundWallet != address(0));
        require(_rate > 0);
        token = _token;
        wallet = _fundWallet;
        subscriptionRate = _rate;
    }

    function renewSubscription(uint256 _userId, uint _day) external {
        require(_day > 0);
        // Calculate amount token amount to purchase by number of day.
        uint256 amount = subscriptionRate.mul(_day);
        uint256 currentExpiration = subscriptionExpiration[_userId];

        // If their membership already expired...
        if (currentExpiration < now) {
            // ...use `now` as the starting point of their new subscription
            currentExpiration = now;
        }
        uint256 newExpiration = currentExpiration.add(_day.mul(1 days));
        subscriptionExpiration[_userId] = newExpiration;

        // Transfer token to our wallet. Always do this last to prevent race conditions.
        require(token.transferFrom(msg.sender, wallet, amount));
        emit SubscriptionPurchase(
            msg.sender,
            _userId,
            _day,
            amount,
            newExpiration);
    }
}