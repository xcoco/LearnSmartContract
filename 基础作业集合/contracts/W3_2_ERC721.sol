import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract ChiFan721 is ERC721 {
    address public owner;
    uint256 public _currentId;
    mapping(address => uint256) public _tokenid;

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: You are not the owner, Bye.");
        _;
    }

    constructor() ERC721("ChiFan 721 Token", "CHIFAN") {
        owner = msg.sender;
        _currentId = 1;
        console.log("ERC721 constructor ", address(this));
    }

    function PublicMint() public {
        require(_tokenid[msg.sender] == 0, "You already have a token");
        _safeMint(msg.sender, _currentId);
        _tokenid[msg.sender] = _currentId;
        _currentId++;
    }

    function GetTokenId(address addr) public view returns (uint256) {
        return _tokenid[addr];
    }

    function SafeTransfer(address to, uint256 tokenId) public {
        require(_tokenid[msg.sender] == tokenId, "You don't have this token");
        transferFrom(msg.sender, to, tokenId);
        _tokenid[msg.sender] = 0;
        _tokenid[to] = tokenId;
        emit Transfer(msg.sender, to, tokenId);
    }
}
