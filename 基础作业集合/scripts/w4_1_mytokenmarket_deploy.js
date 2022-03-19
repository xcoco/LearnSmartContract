const hre = require("hardhat");

async function main () {
  const ChiFanToken = await hre.ethers.getContractFactory("ChiFanToken");
  const chifantoken = await ChiFanToken.deploy();
  await chifantoken.deployed();
  console.log("ERC20 deployed to:", chifantoken.address);

  const TokenMarket = await hre.ethers.getContractFactory("MyTokenMarket");
  const tokenmarket = await TokenMarket.deploy(chifantoken.address, '0xc778417e063141139fce010982780140aa0cd5ab', '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D');

  await tokenmarket.deployed();

  console.log("Market deployed to:", tokenmarket.address);

}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
