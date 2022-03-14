const hre = require("hardhat");

async function main () {
  const ChiFanToken = await hre.ethers.getContractFactory("ChiFanToken");
  const chifantoken = await ChiFanToken.deploy();

  await chifantoken.deployed();

  console.log("ERC20 deployed to:", chifantoken.address);

}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
