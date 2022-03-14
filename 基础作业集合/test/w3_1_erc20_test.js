const { log } = require("console");
const { ethers } = require("hardhat");


const ContractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
const AdminAddress = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
const ToAddress = "0x70997970c51812dc3a010c7d01b50e0d17dc79c8"

let chifanErc20Contract;

async function main () {
  let ChiFanToken = await ethers.getContractFactory("ChiFanToken");
  chifanErc20Contract = ChiFanToken.attach(ContractAddress);
  log("ChiFanToken Contract address:", chifanErc20Contract.address);

  // 增发
  await chifanErc20Contract.AddToken(AdminAddress, ethers.utils.parseEther("1000"));
  let balance = await chifanErc20Contract.balanceOf(AdminAddress);
  log("AdminAddress balance:", ethers.utils.formatEther(balance));
  let tobanlance = await chifanErc20Contract.balanceOf(ToAddress);
  log("ToAddress balance:", ethers.utils.formatEther(tobanlance));

  // 转账
  await chifanErc20Contract.transfer(ToAddress, ethers.utils.parseEther("100"));
  tobanlance = await chifanErc20Contract.balanceOf(ToAddress);
  log("ToAddress balance:", ethers.utils.formatEther(tobanlance));

}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });