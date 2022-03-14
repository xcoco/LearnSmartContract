interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract Vault {
    mapping(address => uint256) public _balances;
    address public _Erc20Token;

    constructor(address token) {
        _Erc20Token = token;
    }

    function balanceOf(address addr) public view returns (uint256) {
        return _balances[addr];
    }

    function deposite(uint256 amount) public {
        IERC20(_Erc20Token).transferFrom(msg.sender, address(this), amount);
        _balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public returns (bool) {
        require(_balances[msg.sender] >= amount, "insufficient balance");
        IERC20(_Erc20Token).transfer(msg.sender, amount);
        _balances[msg.sender] -= amount;
        return true;
    }
}
