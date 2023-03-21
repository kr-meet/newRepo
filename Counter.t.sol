// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ERC20.sol";


contract CounterTest is Test {
    
    ERC20 erc20;
    address meet = address(0x1);
    address manav = address(0x2);
    address adr;

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

    function testGetSender() public {
        adr = erc20.getSender();
        // emit log_address(msg.sender);
        emit log_address(adr);
    }

    

    function testTransfer() public {
        vm.startPrank(meet);
        bool success = erc20.transfer(manav, 10);
        assertEq(success, true);
        // vm.endPrank();
    }

    function testBalanceOf() public {
        uint256 val = erc20.balanceOf(msg.sender);
        // emit log_uint(val);
        assertEq(val, 100);   
    }

    function testApprove() public {

        bool success = erc20.approve(manav, uint256(10));
        assertEq(success, true);
    }

    function testTranferFrom() public {
        bool success = erc20.transferFrom(meet, manav, 1);
        assertEq(success, true);
    }
}
