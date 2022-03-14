const { log } = require("console");
const { ethers } = require("hardhat");

/*
- 编写⼀个 Vault 合约：
  - 编写 deposite ⽅法，实现 ERC20 存⼊ Vault，并记录每个⽤户存款⾦额 ， ⽤从前端调⽤（Approve，transferFrom）
  - 编写 withdraw ⽅法，提取⽤户⾃⼰的存款 （前端调⽤）
  - 前端显示⽤户存款⾦额
*/
const ERC20TokenAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
const VaultAddress = "0x8A791620dd6260079BF849Dc5567aDC3F2FdC318";
const AccountAddress = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";


async function main () {
  let ChiFanToken = await ethers.getContractFactory("ChiFanToken");
  let chifanErc20Contract = ChiFanToken.attach(ERC20TokenAddress);
  log("ChiFanToken Contract address:", chifanErc20Contract.address);

  let Vault = await ethers.getContractFactory("Vault");
  let vault = await Vault.attach(VaultAddress);
  log("Vault Contract address:", vault.address);
  let balance = await vault.balanceOf(AccountAddress);
  log("Vault balance:", ethers.utils.formatEther(balance));
  balance = await chifanErc20Contract.balanceOf(AccountAddress);
  log("ERC20 balance:", ethers.utils.formatEther(balance));

  // deposite
  await chifanErc20Contract.approve(VaultAddress, ethers.utils.parseEther("100"));
  await vault.deposite(ethers.utils.parseEther("100"));
  balance = await vault.balanceOf(AccountAddress);
  log("deposited Vault balance:", ethers.utils.formatEther(balance));

  await vault.withdraw(ethers.utils.parseEther("100"));
  balance = await vault.balanceOf(AccountAddress);
  log("withdrawed Vault balance:", ethers.utils.formatEther(balance));

}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });