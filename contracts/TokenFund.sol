// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenFund is ERC20, ERC2771Context, Ownable{

    constructor(string memory name_, string memory symbol_, address trustedForwarder) ERC20(name_, symbol_) ERC2771Context(trustedForwarder) public {}

    function _msgSender() internal view override(Context, ERC2771Context) returns (address sender) {
        sender = ERC2771Context._msgSender();
    }

    // @dev Corresponds if contexts is both upgradeable and suits ERC2771
    function _msgData() internal view override(Context, ERC2771Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }

    function mint(address account, uint256 amount) public onlyOwner{
        _mint(account, amount);
    }

}
