# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

部署到 rinkeby

npx hardhat run .\scripts\sample-script.js --network rinkeby

部署 tx:https://rinkeby.etherscan.io/tx/0x39c9e3c102441501037fd7128d9ba6901104f3cc0259675b304f26114349499a

合约地址:https://rinkeby.etherscan.io/address/0x4Cf3bC47e5205F2590161cd1C2CA203Ec39065DD#code

验证没配置好,hardhat-etherscan 测试网有问题吧 : npx hardhat verify --network rinkeby 0x4Cf3bC47e5205F2590161cd1C2CA203Ec39065DD
