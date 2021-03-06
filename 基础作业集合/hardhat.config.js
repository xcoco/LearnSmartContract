require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-ganache");

require('dotenv').config();

const PRIVATE_KEY = process.env.MAIN_PRIVATE_KEY;
const HARDHAT_PRIVATE_KEY = process.env.HARDHAT_PRIVATE_KEY;
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

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
  networks: {
    dev: {
      url: "http://127.0.0.1:8545",
      chainId: 31337,
      accounts: [`${HARDHAT_PRIVATE_KEY}`]
    },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${ALCHEMY_API_KEY}`,
      chainId: 4,
      accounts: [`${PRIVATE_KEY}`]
    }

  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  }
};
