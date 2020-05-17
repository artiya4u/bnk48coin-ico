pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";


contract BNK48Coin is ERC20Mintable {

    string public constant name = "BNK48 COIN"; // solium-disable-line uppercase
    string public constant symbol = "BNK48"; // solium-disable-line uppercase
    uint8 public constant decimals = 18; // solium-disable-line uppercase

}