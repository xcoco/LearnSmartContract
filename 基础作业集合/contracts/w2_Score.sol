//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "hardhat/console.sol";

/*
  W2_2 作业
- 编写合约 Score，⽤于记录学⽣（地址）分数：
- 仅有⽼师（⽤ modifier 权限控制）可以添加和修改学⽣分数
- 分数不可以⼤于 100；
- 编写合约 Teacher 作为⽼师，通过 IScore 接⼝调⽤修改学⽣分数。
 */

contract Score {
    address private owner;
    mapping(address => uint256) private scorebook;

    constructor() {
        owner = msg.sender;
    }

    // 这里必须用 tx.origin, 否则只能用 delegatecall 搭配 abi 使用
    modifier onlyOwner() {
        require(tx.origin == owner, "Ownable: You are not the owner, Bye.");
        _;
    }

    function ChangeOwner(address newOwner) external onlyOwner {
        owner = newOwner;
    }

    function ChangeScore(address student, uint256 nscore) external onlyOwner {
        require(nscore <= 100, "Score must be less than 100.");
        scorebook[student] = nscore;
    }

    function SelectScore(address student) external view returns (uint256) {
        return scorebook[student];
    }
}

interface IScore {
    function ChangeScore(address student, uint256 nscore) external;

    function SelectScore(address student) external view returns (uint256);

    function ChangeOwner(address newOwner) external;
}

contract Teacher {
    address private owner;
    address private scorebook;

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: You are not the owner, Bye.");
        _;
    }

    constructor(address _scorebook) {
        owner = msg.sender;
        scorebook = _scorebook;
    }

    function ChangeScore(address student, uint256 nscore) public onlyOwner {
        IScore(scorebook).ChangeScore(student, nscore);
    }

    function SelectScore(address student) public view returns (uint256) {
        return IScore(scorebook).SelectScore(student);
    }

    function ChangeOwner(address newOwner) public onlyOwner {
        IScore(scorebook).ChangeOwner(newOwner);
    }
}
