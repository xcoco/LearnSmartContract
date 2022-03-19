# 作业

## W4_1 作业

- 部署自己的 ERC20 合约 MyToken
- 编写合约 MyTokenMarket 实现：
  - AddLiquidity():函数内部调用 UniswapV2Router 添加 MyToken 与 ETH 的流动性
  - buyToken()：用户可调用该函数实现购买 MyToken

部署
npx hardhat run .\scripts\w4_1_mytokenmarket_deploy.js --network rinkeby

> ERC20 deployed to: 0xfd87Dd715d164c486f27E518a083687E509810EE
> Market deployed to: 0x856bE00e6da147843294F0E66cC65C89a47abFcD

验证:
npx hardhat verify 0xfd87Dd715d164c486f27E518a083687E509810EE --network rinkeby --contract contracts/W3_1_ERCToken.sol:ChiFanToken
npx hardhat verify 0x856bE00e6da147843294F0E66cC65C89a47abFcD --network rinkeby --contract contracts/w4_1_MyTokenMarket.sol:MyTokenMarket '0xfd87Dd715d164c486f27E518a083687E509810EE', '0xc778417e063141139fce010982780140aa0cd5ab', '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D'

测试
npx hardhat run .\test\w4_1_mytokenmarket_test.js --network rinkeby

> ChiFanToken Contract address: 0xfd87Dd715d164c486f27E518a083687E509810EE
> Current Wallet address: 0x222222f8685F4Fdec8f164cEdE16fE6572817a1A
> 增发 balance: 9500.248873309964947421
> 添加流动性后 balance: 9500.248873309964947421 // 由于区块打包的原因并没有及时生效
> 购买 token 后 balance: 9500.248873309964947421

## W4_2 作业

- 在上一次作业的基础上：
  - 完成代币兑换后，直接质押 MasterChef
  - withdraw():从 MasterChef 提取 Token 方法

## W3_1 作业

- 发⾏⼀个 ERC20 Token：
  - 可动态增发（起始发⾏量是 0）
  - 通过 ethers.js. 调⽤合约进⾏转账
- 编写⼀个 Vault 合约：
  - 编写 deposite ⽅法，实现 ERC20 存⼊ Vault，并记录每个⽤户存款⾦额 ， ⽤从前端调⽤（Approve，transferFrom）
  - 编写 withdraw ⽅法，提取⽤户⾃⼰的存款 （前端调⽤）
  - 前端显示⽤户存款⾦额

### 作业路径指引:

相关文件 ERC20 Token:
合约: contracts/w3_1_ERCToken.sol
部署脚本: scripts/w3_1_erc20_deploy.js
测试脚本: test\w2_bank_test.js

- 部署
  npx hardhat run scripts/w3_1_erc20_deploy.js --network dev
- 测试
  npx hardhat run .\test\w3_1_erc20_test.js --network dev

> ChiFanToken Contract address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
> AdminAddress balance: 1000.0
> ToAddress balance: 0.0
> ToAddress balance: 100.0

相关文件 Vault:
合约: contracts/w3_1_Vault.sol
部署脚本: scripts/w3_1_vault_deploy.js
测试脚本: test\w3_1_vault_test.js

- 部署
  npx hardhat run .\scripts\w3_1_vault_deploy.js --network dev
  > vault deployed to: 0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9
- 测试
  npx hardhat run .\test\w3_1_vault_test.js --network dev

> ChiFanToken Contract address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
> Vault Contract address: 0x8A791620dd6260079BF849Dc5567aDC3F2FdC318
> Vault balance: 0.0
> ERC20 balance: 800.0
> deposited Vault balance: 100.0
> withdrawed Vault balance: 0.0

## W3_2 作业

- 发行一个 ERC721 Token
  - 使用 ether.js 解析 ERC721 转账事件(加分项：记录到数据库中，可方便查询用户持有的所有 NFT)
  - (或)使用 TheGraph 解析 ERC721 转账事件

相关文件:
合约: contracts/w3_2_ERC721.sol
部署脚本: scripts/w3_2_erc721_deploy.js
测试脚本: test\w3_3_event_log_test.js

- 部署
  npx hardhat run scripts/w3_2_erc721_deploy.js --network dev
- 测试
  npx hardhat run .\test\w3_3_event_log_test.js --network dev
  npx hardhat run .\test\w3_2_erc721_test.js --network dev

> npx hardhat run .\test\w3_2_event_log_test.js --network dev
> owner: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 erc721 address: 0x4826533B4897376654Bb4d4AD88B7faFD0C98528
> from : 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 to: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 tokenid: 3
> from : 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 to: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 tokenid: 3
> from : 0x0000000000000000000000000000000000000000 to: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 tokenid: 4
> from : 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 to: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 tokenid: 4
> from : 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 to: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 tokenid: 4

> npx hardhat run .\test\w3_2_erc721_test.js --network dev
> balance: BigNumber { value: "0" }
> ERC721 token: 4
> ERC721 Me balance: BigNumber { value: "0" }
> ERC721 To balance: BigNumber { value: "3" }
> transferFromed ERC721 Me balance: BigNumber { value: "0" }
> transferFromed ERC721 To balance: BigNumber { value: "4" }

---

## W2_1 作业：

- 编写⼀个 Bank 合约：
- 通过 Metamask 向 Bank 合约转账 ETH
- 在 Bank 合约记录每个地址转账⾦额
- 编写 Bank 合约 withdraw(), 实现提取出所有的 ETH

#### 作业路径指引:

相关文件:
合约: contracts/w2_bank.sol
部署脚本: scripts/w2_bank_deploy.js
测试脚本: test\w2_bank_test.js

- 部署
  npx hardhat run scripts/w2_bank_deploy.js --network rinkeby

- 验证
  npx hardhat verify 0xc5F2644C1Ea29f328347980E92344a92D5d6f852 --network rinkeby --contract contracts/w2_bank.sol:Bank

> Successfully verified contract Bank on Etherscan.
> https://rinkeby.etherscan.io/address/0xc5F2644C1Ea29f328347980E92344a92D5d6f852#code

- 测试
  > npx hardhat run .\test\w2_bank_test.js --network dev

## W2_2 作业

- 编写合约 Score，⽤于记录学⽣（地址）分数：
  - 仅有⽼师（⽤ modifier 权限控制）可以添加和修改学⽣分数
  - 分数不可以⼤于 100；
- 编写合约 Teacher 作为⽼师，通过 IScore 接⼝调⽤修改学⽣分数。

### 作业路径指引:

相关文件:
合约: contracts/w2_Score.sol
部署脚本: scripts/w2_score_deploy.js

- 部署
  npx hardhat run .\scripts\w2_score_deploy.js --network rinkeby

  > score deployed to: 0x201afC5d7ff111606094d407eD049354C0909b26
  > teacher deployed to: 0x7Dc1eA054dC34e3b4893A76476F1287cf5D00464

- 验证
  npx hardhat verify 0x201afC5d7ff111606094d407eD049354C0909b26 --network rinkeby --contract contracts/w2_Score.sol:Score
  npx hardhat verify 0x7Dc1eA054dC34e3b4893A76476F1287cf5D00464 --network rinkeby --contract contracts/w2_Score.sol:Teacher 0x201afC5d7ff111606094d407eD049354C0909b26

> Successfully verified contract Bank on Etherscan.
> https://rinkeby.etherscan.io/address/0x201afC5d7ff111606094d407eD049354C0909b26#code > https://rinkeby.etherscan.io/address/0x7Dc1eA054dC34e3b4893A76476F1287cf5D00464#code

- 测试
  > enters.js 测试复杂 remix 内测试

---

## w1 作业

部署到 rinkeby

npx hardhat run .\scripts\sample-script.js --network rinkeby

部署 tx:https://rinkeby.etherscan.io/tx/0x39c9e3c102441501037fd7128d9ba6901104f3cc0259675b304f26114349499a

合约地址:https://rinkeby.etherscan.io/address/0x4Cf3bC47e5205F2590161cd1C2CA203Ec39065DD#code

验证没配置好,hardhat-etherscan 测试网有问题吧 : npx hardhat verify --network rinkeby 0x4Cf3bC47e5205F2590161cd1C2CA203Ec39065DD
