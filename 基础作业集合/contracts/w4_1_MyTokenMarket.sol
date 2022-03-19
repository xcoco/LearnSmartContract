//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./IUniswapV2Router01.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MyTokenMarket {
    using SafeERC20 for IERC20;
    address weth;
    address public token;
    address public router;

    constructor(
        address _token,
        address _weth,
        address _router
    ) public {
        weth = _weth;
        token = _token;
        router = _router;
    }

    function AddLiquidity(uint256 tokenAmount) public payable {
        require(tokenAmount > 0, "tokenAmount must be greater than 0");
        require(msg.value > 0, "msg.value must be greater than 0");

        IERC20(token).safeTransferFrom(msg.sender, address(this), tokenAmount);
        IERC20(token).safeApprove(router, tokenAmount);
        IUniswapV2Router01(router).addLiquidityETH{value: msg.value}(
            token,
            tokenAmount,
            0,
            0,
            msg.sender,
            block.timestamp
        );
    }

    function BuyToken(uint256 miniTokenAmount) public payable {
        require(msg.value > 0, "msg.value must be greater than 0");
        require(miniTokenAmount > 0, "tokenAmount must be greater than 0");
        address[] memory path = new address[](2);
        path[0] = weth;
        path[1] = token;
        IUniswapV2Router01(router).swapExactETHForTokens{value: msg.value}(
            miniTokenAmount,
            path,
            msg.sender,
            block.timestamp
        );
    }

    function ApproveMust() public {
        IERC20(token).safeApprove(address(this), 100000000);
        IERC20(token).safeTransferFrom(msg.sender, address(this), 1024);
    }
}
