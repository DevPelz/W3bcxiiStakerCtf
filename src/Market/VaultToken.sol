// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "src/Market/ERC20.sol";

contract VaultTokens is ERC20 {
    address public owner;

    constructor() ERC20("VaultTokens", "VT", 18) {
        owner = msg.sender;
    }

    function mintToMarket(address addr) external {
        require(msg.sender == owner, "NOT_AUTHORIZED");
        _mint(addr, uint256(1e18));
    }
}
