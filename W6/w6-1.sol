pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract CallOptionsToken is ERC20 {
    using SafeERC20 for IERC20;
    uint256 public price;
    address public paytoken;
    uint256 public exeTime;
    uint256 public constant during = 10 days;
    mapping(address => uint256) public balances;

    // 这里必须用 tx.origin, 否则只能用 delegatecall 搭配 abi 使用
    modifier onlyOwner() {
        require(tx.origin == owner, "Ownable: You are not the owner, Bye.");
        _;
    }

    function ChangeOwner(address newOwner) external onlyOwner {
        owner = newOwner;
    }

    constructor(address tokenaddr) ERC20("Options Token", "OPT") {
        paytoken = tokenaddr;
        price = 10000; //10000 token = 1 OPT
        exeTime = block.timestamp + 15 days;
        owner = msg.sender;
    }

    function mint(address useraddr) external payable onlyOwner {
        _mint(useraddr, msg.value * 20); //1 OPT = 20倍 ETH
    }

    //行权
    function ExerciseOPT(uint256 amount) external {
        require(
            block.timestamp >= exeTime && block.timestamp < exeTime + during,
            "invalid time"
        );
        require(amount > 0 && balanceOf(msg.sender) >= amount);
        _burn(msg.sender, amount);
        uint256 needTokenAmount = price * amount;
        IERC20(paytoken).safeTransferFrom(
            msg.sender,
            address(this),
            needTokenAmount
        );
        safeTransferETH(msg.sender, amount);
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, "safeTransferETH: ETH transfer failed");
    }

    // 销毁所有
    function burnAll() external onlyOwner {
        require(block.timestamp >= exeTime + during, "Exercise  It's OVER");
        uint256 tokenAmount = IERC20(paytoken).balanceOf(address(this));
        IERC20(paytoken).safeTransfer(msg.sender, tokenAmount);
        selfdestruct(payable(msg.sender));
    }

    function withdrawall() public onlyOwner {
        require(address(this).balance > 0);
        (bool status, ) = owner.call{value: address(this).balance}("");
        require(status, "withdraw failed");
    }

    receive() external payable {
        console.log("in receive");
        balances[msg.sender] += msg.value;
    }
}
