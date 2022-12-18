pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenFund is ERC20, ERC2771Context, Ownable{

    function mint(address account, uint256 amount) onlyOwner{
        _mint(account, amount);
    }

}
