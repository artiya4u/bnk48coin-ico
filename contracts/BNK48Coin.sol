pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";


contract BNK48Coin is MintableToken {

  string public constant name = "BNK48 COIN"; // solium-disable-line uppercase
  string public constant symbol = "BNK48"; // solium-disable-line uppercase
  uint8 public constant decimals = 18; // solium-disable-line uppercase

}
