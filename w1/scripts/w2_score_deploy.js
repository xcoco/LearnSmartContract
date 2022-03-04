const hre = require("hardhat");

async function main () {
  const Score = await hre.ethers.getContractFactory("Score");
  const score = await Score.deploy();

  await score.deployed();

  console.log("score deployed to:", score.address);

  const Teacher = await hre.ethers.getContractFactory("Teacher");
  const teacher = await Teacher.deploy(score.address);

  await teacher.deployed();

  console.log("teacher deployed to:", teacher.address);


}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
