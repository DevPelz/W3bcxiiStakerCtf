// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "src/W3bCxiiStaker.sol";
import "../src/erc20.sol";
import "../src/feeManager.sol";

contract StakingContractTest is Test {
    W3bCxiiStaker w3bCxiiStaker;
    erc20Token usdc;
    FeeManager feeManager;

    address admin = makeAddr("admin");
    address Alice = makeAddr("Alice");
    address Hacker = makeAddr("Hacker");

    function setUp() public {
        vm.startPrank(admin);

        //Setting up Contracts
        usdc = new erc20Token("USD Coin", "USDC", 0);
        feeManager = new FeeManager();
        w3bCxiiStaker = new W3bCxiiStaker(address(usdc), address(feeManager));

        //Intial Balances of the user.
        usdc.mint(Alice, 100);
        usdc.mint(Hacker, 100);

        vm.stopPrank();
    }

    function testExploit() public {
        vm.prank(admin);
        usdc.mint(Alice, 1000);

        vm.startPrank(Alice);
        usdc.approve(address(w3bCxiiStaker), type(uint256).max);
        w3bCxiiStaker.stake(100);
        vm.stopPrank();

        assertEq(w3bCxiiStaker.stakedBalances(Alice), 100);

        vm.startPrank(Hacker);
        // YOUR SOLUTION HERE
        vm.stopPrank();

        // 360 Seconds Passed?
        vm.warp(block.timestamp + 360);

        vm.startPrank(Hacker);
        // YOUR SOLUTION HERE
        vm.stopPrank();

        assertEq(usdc.balanceOf(Hacker), 200);
        assertEq(usdc.balanceOf(address(w3bCxiiStaker)), 0);
    }
}
