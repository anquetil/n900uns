// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {N900UNS} from "../src/N900UNS.sol";

contract N900UNSTest is Test, IERC721Receiver {
   N900UNS n900uns;

   receive() external payable {} // can receive ETH
   
   function setUp() public {
      console2.log("hello");
      console2.log(address(this));
      n900uns = new N900UNS(address(this));
   }

   function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
      return IERC721Receiver.onERC721Received.selector;
   }

   function test_Withdraw() public {
      console2.log(address(this));
      uint256 initialBalance = address(this).balance;
      n900uns.mintNext{value: 0.01 ether}();
      assertEq(address(n900uns).balance, 10000000000000000);
      assertEq(address(this).balance, initialBalance - 10000000000000000);
      n900uns.withdraw();
      assertEq(address(n900uns).balance, 0);
      assertEq(address(this).balance, initialBalance );
   }

   function test_Increment() public {
      console2.log(address(this));
      n900uns.mintNext{value: 0.01 ether}();
      assertEq(n900uns.totalSupply(), 2);
   }
}
