# 作业

W2_1 作业：

- 编写⼀个 Bank 合约：
- 通过 Metamask 向 Bank 合约转账 ETH
- 在 Bank 合约记录每个地址转账⾦额
- 编写 Bank 合约 withdraw(), 实现提取出所有的 ETH

作业路径指引:
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

W2_2 作业

- 编写合约 Score，⽤于记录学⽣（地址）分数：
  - 仅有⽼师（⽤ modifier 权限控制）可以添加和修改学⽣分数
  - 分数不可以⼤于 100；
- 编写合约 Teacher 作为⽼师，通过 IScore 接⼝调⽤修改学⽣分数。

作业路径指引:
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

w1 作业

部署到 rinkeby

npx hardhat run .\scripts\sample-script.js --network rinkeby

部署 tx:https://rinkeby.etherscan.io/tx/0x39c9e3c102441501037fd7128d9ba6901104f3cc0259675b304f26114349499a

合约地址:https://rinkeby.etherscan.io/address/0x4Cf3bC47e5205F2590161cd1C2CA203Ec39065DD#code

验证没配置好,hardhat-etherscan 测试网有问题吧 : npx hardhat verify --network rinkeby 0x4Cf3bC47e5205F2590161cd1C2CA203Ec39065DD
