// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ERC20.sol";


contract CounterTest is Test {
    
    ERC20 erc20;
    address meet = address(0x1);
    address manav = address(0x2);
    address adr = address(0x3);

    function setUp() public {
        erc20 = new ERC20("JARVIS", "JAR");
    }

    function testName() public {
        assertEq("JARVIS", erc20.name());
    }

    function testSymbol() public {
        assertEq("JAR", erc20.symbol());
    }

    function testDecimals() public {
        assertEq(18, erc20.decimals());
    }

    function testTotalSupply() public {
        assertEq(100, erc20.totalSupply());
    }

    function testTransfer() public {
        vm.startPrank(meet);
        bool success = erc20.transfer(manav, 10);
        assertEq(success, true);
        vm.stopPrank();
    }

    function testApprove() public {

        erc20.mint(meet, 10);

        vm.startPrank(meet);

        bool success = erc20.approve(manav, 11);
        assertEq(success, true);

        uint256 val = erc20.allowance(meet, manav);
        emit log_uint(val);
        assertEq(val, 11);

        erc20.increaseAllowance(manav, 1);

        val = erc20.allowance(meet, manav);
        emit log_uint(val);
        assertEq(val, 12);

        erc20.decreaseAllowance(manav, 1);

        val = erc20.allowance(meet, manav);
        emit log_uint(val);
        assertEq(val, 11);
        
        erc20.transfer(adr, 2);
        val = erc20.balanceOf(adr);
        assertEq(val,2);

        vm.stopPrank();  
        vm.startPrank(manav);

        erc20.transferFrom(meet, adr, 2);
        val = erc20.balanceOf(adr);
        assertEq(val,4);
        emit log_uint(val);

        val = erc20.allowance(meet, manav);
        emit log_uint(val);
        assertEq(val, 9);
    }

    // function testTranferFrom() public {
    //     bool success = erc20.transferFrom(meet, manav, 1);
    //     assertEq(success, true);
    // }

    function testMint() public {

        erc20.mint(meet, 10);
        uint256 val = erc20.balanceOf(meet);
        assertEq(val,10);
        emit log_uint(val);
        erc20.transfer(meet, manav, 1);
        val = erc20.balanceOf(manav);
        assertEq(val,1);
        emit log_uint(val);
    }
}
