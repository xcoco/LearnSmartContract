//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./IUniswapV2Router01.sol";
import "./IMasterChef.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MyTokenMarket {
    using SafeERC20 for IERC20;
    address weth;
    address public token;
    address public router;
    address public masterchef;
    address public shushitoken;

    constructor(
        address _token,
        address _weth,
        address _router,
        address _masterchef,
        address _sushi
    ) public {
        weth = _weth;
        token = _token;
        router = _router;
        masterchef = _masterchef;
        shushitoken = _sushi;
    }

    function AddLiquidity(uint256 tokenAmount) public payable {
        require(tokenAmount > 0, "tokenAmount must be greater than 0");
        require(msg.value > 0, "msg.value must be greater than 0");

        IERC20(token).safeTransferFrom(msg.sender, address(this), tokenAmount);
        IERC20(token).safeIncreaseAllowance(router, tokenAmount);
        IUniswapV2Router01(router).addLiquidityETH{value: msg.value}(
            token,
            tokenAmount,
            0,
            0,
            msg.sender,
            block.timestamp
        );
    }

    function WithAllShuShiTokens() private {
        uint256 balance = IERC20(shushitoken).balanceOf(address(this));
        if (balance <= 0) {
            return;
        }
        IERC20(shushitoken).transfer(msg.sender, balance);
    }

    function WithAllMyTokens() private {
        uint256 balance = IERC20(token).balanceOf(address(this));
        if (balance <= 0) {
            return;
        }
        IERC20(token).transfer(msg.sender, balance);
    }

    function WithAllToken() private {
        WithAllShuShiTokens();
        WithAllMyTokens();
    }

    function BuyToken(uint256 miniTokenAmount) public payable {
        require(msg.value > 0, "msg.value must be greater than 0");
        require(miniTokenAmount > 0, "tokenAmount must be greater than 0");
        address[] memory path = new address[](2);
        path[0] = weth;
        path[1] = token;
        uint256[] memory amounts = new uint256[](2);
        amounts = IUniswapV2Router01(router).swapExactETHForTokens{
            value: msg.value
        }(miniTokenAmount, path, address(this), block.timestamp);

        IERC20(token).safeApprove(masterchef, amounts[1]);
        IMasterChef(masterchef).deposit(0, amounts[1]);
        WithAllToken();
    }

    function ApproveMust() public {
        IERC20(token).safeApprove(address(this), 100000000);
        IERC20(token).safeTransferFrom(msg.sender, address(this), 1024);
    }

    function MasterChefWithdraw(uint256 amount) public {
        IMasterChef(masterchef).withdraw(0, amount);
        WithAllToken();
    }
}
