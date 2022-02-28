//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greeter {
    uint256 private counter;

    constructor() {
        console.log("Deploying a Greeter");
    }

    function setCounter(uint256 _count) public {
        console.log("in setCounter");
        counter = _count;
    }

    function GetCounter() public view returns (uint256) {
        console.log("in GetCounter");
        return counter;
    }
}
