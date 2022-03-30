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

contract FlashSwapTest {
    address private owner;

    IUniswapV2Factory constant uniswapV2Factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    ISwapRouter constant uniswapV3SwapRouter =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    address public _tokenBorrow = 0x7F988F48bf83aeDCe16804f8c2aA4D3Cd501dFe8; // MFT
    address public _tokenPay = 0xB4C0C825538869f2657424F66C448d00Bb7C2A48; // LPT

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: You are not the owner, Bye.");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function transferPair(address token, uint256 amount) private {
        if (amount > 0) {
            uint256 fee = ((amount * 3) / 997) + 1;
            uint256 amountToRepay = amount + fee;
            IERC20(token).transfer(msg.sender, amountToRepay);
        }
    }

    function uniswapV2Call(
        address sender,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external {
        require(
            amount0 == 0 || amount1 == 0,
            "amount0 or amount1 should be zero"
        );
        // 解析借款参数
        (address borrowToken, uint256 amount) = abi.decode(
            data,
            (address, uint256)
        );

        address paytoken = borrowToken == _tokenBorrow
            ? _tokenPay
            : _tokenBorrow;

        bytes memory path = abi.encodePacked(
            borrowToken,
            uint24(3000), //poolFee
            paytoken
        );

        IERC20(borrowToken).approve(address(uniswapV3SwapRouter), amount);
        uniswapV3SwapRouter.exactInput{value: 0}(
            ISwapRouter.ExactInputParams({
                path: path,
                recipient: address(this),
                deadline: block.timestamp + 2000,
                amountIn: amount,
                amountOutMinimum: 0
            })
        );

        transferPair(borrowToken, amount);
    }

    function flashswap(uint256 _amount) public {
        address pair = uniswapV2Factory.getPair(_tokenBorrow, _tokenPay);
        address token0 = IUniswapV2Pair(pair).token0();
        address token1 = IUniswapV2Pair(pair).token1();
        require(pair != address(0), "pair get error");
        bytes memory data = abi.encode(_tokenPay, _amount);
        uint256 amount0Out = _tokenPay == address(token0) ? _amount : 0;
        uint256 amount1Out = _tokenPay == address(token1) ? _amount : 0;
        IUniswapV2Pair(pair).swap(amount0Out, amount1Out, address(this), data);
        withall();
    }

    function withall() private {
        uint256 balance = IERC20(_tokenBorrow).balanceOf(address(this));
        IERC20(_tokenBorrow).transfer(msg.sender, balance);
        balance = IERC20(_tokenPay).balanceOf(address(this));
        IERC20(_tokenPay).transfer(msg.sender, balance);
    }

    function exctInputV32sb(uint256 amount, uint24 free) public {
        ISwapRouter uniswapV3SwapRouter3 = ISwapRouter(
            0xE592427A0AEce92De3Edee1F18E0157C05861564
        );
        //uint256 free = ((amount * 10) / 977) + 1;
        IERC20(_tokenPay).approve(address(uniswapV3SwapRouter3), amount * 2);
        IERC20(_tokenBorrow).approve(address(uniswapV3SwapRouter3), amount * 2);
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: _tokenPay,
                tokenOut: _tokenBorrow,
                fee: uint24(free),
                recipient: address(this),
                deadline: block.timestamp + 1,
                amountIn: amount,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        uniswapV3SwapRouter3.exactInputSingle(params);
    }
}
