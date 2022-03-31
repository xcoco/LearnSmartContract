import "./UniswapV2Interfaces.sol";

interface IV2SwapRouter {
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

contract FlashSwapSwap {
    IUniswapV2Factory constant uniswapV2Factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    ISwapRouter constant uniswapV3SwapRouter =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    IV2SwapRouter constant uniswapV2SwapRouter =
        IV2SwapRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    address public _tokenBorrow = 0x7F988F48bf83aeDCe16804f8c2aA4D3Cd501dFe8; // MFT
    address public _tokenPay = 0xB4C0C825538869f2657424F66C448d00Bb7C2A48; // LPT
    mapping(address => uint256) private _borrow;

    function withall() private {
        uint256 balance = IERC20(_tokenBorrow).balanceOf(address(this));
        if (balance > 0) {
            IERC20(_tokenBorrow).transfer(msg.sender, balance);
            balance = IERC20(_tokenPay).balanceOf(address(this));
            IERC20(_tokenPay).transfer(msg.sender, balance);
        }
    }

    // 借钱  授权后调用
    function Borrowing(uint256 amount) public {
        IERC20(_tokenBorrow).transferFrom(msg.sender, address(this), amount);
        _borrow[msg.sender] = amount;
    }

    function swapV2toV3(uint256 amount) public {
        // 授权
        address[] memory path = new address[](2);
        path[0] = _tokenBorrow; //MFT
        path[1] = _tokenPay; //LPT
        IERC20(_tokenBorrow).approve(address(uniswapV2SwapRouter), amount);
        uint256[] memory amounts = uniswapV2SwapRouter.swapExactTokensForTokens(
            amount,
            0,
            path,
            address(this),
            block.timestamp
        );

        IERC20(_tokenPay).approve(address(uniswapV3SwapRouter), amounts[1]);
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: _tokenPay,
                tokenOut: _tokenBorrow,
                fee: uint24(3000),
                recipient: address(this),
                deadline: block.timestamp + 1000,
                amountIn: amounts[1],
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        uniswapV3SwapRouter.exactInputSingle(params);
        // 还钱
        IERC20(_tokenBorrow).transfer(msg.sender, _borrow[msg.sender]);
    }
}
