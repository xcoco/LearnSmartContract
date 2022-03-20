const hre = require("hardhat");

async function main () {
  const SushiToken = await hre.ethers.getContractFactory("SushiToken");
  const sushitoken = await SushiToken.deploy();
  await sushitoken.deployed();
  console.log("sushitoken deployed to:", sushitoken.address);
  const MasterChef = await hre.ethers.getContractFactory("MasterChef");
  const masterchef = await MasterChef.deploy(sushitoken.address, '0x222222f8685F4Fdec8f164cEdE16fE6572817a1A', ethers.utils.parseEther("10240000"), '0', '0xF22222f8685F4Fdec8f164cEdE16fE6572817a1A');
  await masterchef.deployed();
  console.log("MasterChef deployed to:", masterchef.address);

  let gaslimitOption = {
    gasLimit: 4000000,
    gasPrice: ethers.utils.parseUnits("60", "gwei")
  };
  // 修改 sushitoken 中的 owner
  await sushitoken.transferOwnership(masterchef.address, gaslimitOption);

}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
