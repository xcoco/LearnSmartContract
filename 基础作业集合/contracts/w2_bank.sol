//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "hardhat/console.sol";

/*
* W2_1作业：
* 编写⼀个Bank合约：

* 通过 Metamask 向Bank合约转账ETH
* 在Bank合约记录每个地址转账⾦额
* 编写 Bank合约withdraw(), 实现提取出所有的 ETH
*/

contract Bank {
    address payable public owner;
    mapping(address => uint256) public balances;
    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: You are not the owner, Bye.");
        _;
    }

    function deposit(address _to, uint256 _value) public {
        balances[_to] += _value;
    }

    receive() external payable {
        console.log("in receive");
        balances[msg.sender] += msg.value;
    }

    // 当被调用一个不存在的函数时，会触发此函数
    fallback() external payable {
        console.log("in fallback");
        require(false, "No Function");
    }

    function transfer(address _to, uint256 _value) public {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }

    function withdraw() public {
        require(balances[msg.sender] > 0);
        (bool status, ) = msg.sender.call{value: balances[msg.sender]}("");
        balances[msg.sender] = 0;
        require(status, "withdraw failed");
    }

    function withdrawall() public onlyOwner {
        require(address(this).balance > 0);
        (bool status, ) = owner.call{value: address(this).balance}("");
        require(status, "withdraw failed");
    }

    function getBalance(address _addr) public view returns (uint256) {
        return balances[_addr];
    }

    function getAllBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
