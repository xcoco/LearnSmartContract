import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ChiFanToken is ERC20 {
    address private owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: You are not the owner, Bye.");
        _;
    }

    constructor() public ERC20("ChiFan Token", "CFT") {
        owner = msg.sender;
    }

    // 动态增发
    function AddToken(address addres, uint256 number) public onlyOwner {
        _mint(addres, number);
    }
}
