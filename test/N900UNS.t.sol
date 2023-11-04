// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {N900UNS} from "../src/N900UNS.sol";

contract N900UNSTest is Test {
   N900UNS n900uns;

   function setUp() public {
      console2.log("hello");
      console2.log(address(this));
      n900uns = new N900UNS(address(this));
   }

   function test_Increment() public {
      n900uns.mintNext();
      console2.log(n900uns.totalSupply());
      assertEq(n900uns.totalSupply(), 1);
   }
}
