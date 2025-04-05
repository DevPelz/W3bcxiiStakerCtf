// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <= 0.9.0;
pragma experimental ABIEncoderV2;

import "src/Market/VaultToken.sol";
import "forge-std/Test.sol";
import "src/Market/TokenMarket.sol";

contract StakingContractTest is Test {
    VaultTokens public tokens;
    TokenMarket public market;

    address user = makeAddr("user");
    address admin = makeAddr("admin");

    function setUp() public {
        deal(user, 100 ether);
        vm.startPrank(admin);
        tokens = new VaultTokens();
        market = new TokenMarket(address(tokens));
        tokens.mintToMarket(address(market));
        vm.stopPrank();
    }

    function testExploit() public {
        vm.startPrank(user);
        // code your exploit here
        vm.stopPrank();

        assertTrue(validate());
    }

    function validate() public view returns (bool) {
        return market.isComplete() && market.drained();
    }
}
