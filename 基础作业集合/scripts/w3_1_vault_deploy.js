const hre = require("hardhat");

async function main () {
  const Vault = await hre.ethers.getContractFactory("Vault");
  const vault = await Vault.deploy("0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512");

  await vault.deployed();

  console.log("vault deployed to:", vault.address);

}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
