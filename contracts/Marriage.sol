// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

//import "./interface/ISafe.sol";
import "./office/Office.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Marriage {

    Office public immutable office;
    mapping(address=>bool) internal familyAddresses;
    address [] public familyFunds;

    struct FamilyFund{
        address fund;
        ERC20 token;
    }

    modifier onlyFamilyAddress(){
        require(familyAddresses[msg.sender], "Only family address");
        _;
    }

    event SafeDeployed(address safe);

    constructor(Office _office, address [] memory _familyAddresses) {
        office = _office;
        for(uint i; i<_familyAddresses.length; i++){
            familyAddresses[_familyAddresses[i]]=true;
        }
    }

    function deploySafe(address[] memory owners, uint256 threshold)
    public
    returns (address)
    {
        bytes memory emptyBytes;
        bytes memory initial = abi.encodeWithSelector(
            ISafe.setup.selector,
            owners,
            threshold,
            address(0),
            emptyBytes,
            office.safeFallbackHandler(),
            address(0),
            0,
            payable(address(0))
        );
        ISafe safe = office.safeFactory().createProxy(address(office.safeSingleton()), initial);
        familyFunds.push(address(safe));
        emit SafeDeployed(address(safe));

        return address(safe);
    }
}
