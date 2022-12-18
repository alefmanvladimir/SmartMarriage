// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "../interface/ISafe.sol";

contract Office {
    ISafe public immutable safeSingleton;
    ISafeFactory public immutable safeFactory;
    address public immutable safeFallbackHandler;

    constructor(
        ISafe safeSingleton_,
        ISafeFactory safeFactory_,
        address safeFallbackHandler_
    ) {
        safeSingleton = safeSingleton_;
        safeFactory = safeFactory_;
        safeFallbackHandler = safeFallbackHandler_;
    }
}
