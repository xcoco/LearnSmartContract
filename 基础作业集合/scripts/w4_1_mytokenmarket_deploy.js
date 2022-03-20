const hre = require("hardhat");

async function main () {
  const ChiFanToken = await hre.ethers.getContractFactory("ChiFanToken");
  const chifantoken = await ChiFanToken.deploy();
  await chifantoken.deployed();
  console.log("ERC20 deployed to:", chifantoken.address);


  const TokenMarket = await hre.ethers.getContractFactory("MyTokenMarket");
  const tokenmarket = await TokenMarket.deploy(/*'0xE003bCB637c3f290227E68a414c40f03a3909ef7'*/chifantoken.address, '0xc778417e063141139fce010982780140aa0cd5ab', '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D',
    '0x00DE7cfcF928eadE7bfe985CE0Ec6f086fd3538d', '0xc23b98723268418bB630B37251A8536585945661', {
    gasLimit: 4000000,
    gasPrice: ethers.utils.parseUnits("60", "gwei")
  });

  await tokenmarket.deployed();

  console.log("Market deployed to:", tokenmarket.address);

}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
