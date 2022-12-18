pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./TokenFund.sol";

contract Fund {

    address [] owners;
    TokenFund public token;
    address [] tokens;
//    address [] nftCollections;

    constructor(address [] memory _owners, uint256 [] memory _shares, string memory name, string memory symbol){
        require(_owners.length==_shares.length, "validation error");
        uint totalShare;
        for(uint i; i<_shares.length; i++){
            totalShare+=_shares[i];
        }
        require(totalShare==10**token.decimals() * 100, "incorrect shares");
        owners = _owners;
        token = new TokenFund(name, symbol);
        for(uint i; _owners.length; i++){
            token.mint(_owners[i], _shares[i]);
        }
    }

    function closeFund() public {
        _withdrawNativeToken();
        for(uint i; i<tokens.length; i++){
            _withdrawERC20Token(tokens[i]);
        }
    }

    function _withdrawNativeToken() internal{
        for(uint i; i<owners.length; i++){
            uint amount = address(this).balance * (10 ** token.decimals()) / token.balanceOf(owners[i]);
            address(owners[i]).transfer(amount);
        }
    }

    function _withdrawERC20Token(address _tokenAddress) internal{
        for(uint i; i<owners.length; i++){
            uint amount = ERC20(_tokenAddress).balanceOf(address(this)) * (10 ** token.decimals()) / token.balanceOf(owners[i]);
            ERC20(_tokenAddress).transfer(owners[i], amount);
        }
    }

}
