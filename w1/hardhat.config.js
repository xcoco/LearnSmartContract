require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config();

const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY
const ETHERSCAN_API_KEY =  process.env.ETHERSCAN_API_KEY

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "rinkeby",
  solidity: "0.8.4",
  networks:{
    development:{
      url:"http://127.0.0.1:8545",
      chainId:31337
    },
    rinkeby:{
      url:`https://rinkeby.infura.io/v3/${ALCHEMY_API_KEY}`,
      chainId:4,
      accounts:[`0x${PRIVATE_KEY}`]
    },
    etherscan:{
      url:`https://api-rinkeby.etherscan.io/api?apikey=${ETHERSCAN_API_KEY}`,
      apiKey: ETHERSCAN_API_KEY
    }
  }
};
