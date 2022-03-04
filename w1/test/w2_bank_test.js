const { log } = require("console");
const { ethers } = require("hardhat");

const bankConttractAddress = "0x9A9f2CCfdE556A7E9Ff0848998Aa4a0CFD8863AE";
const selectAddress = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";

let bankContract;

async function main () {
  let Bank = await ethers.getContractFactory("Bank");
  bankContract = Bank.attach(bankConttractAddress);
  log("Bank Contract address:", bankContract.address);

  let balancecount = await bankContract.getAllBalance();
  log("Bank all balance:", ethers.utils.formatEther(balancecount));

  let num = await bankContract.getBalance(selectAddress)
  log("ETH:", ethers.utils.formatEther(num));

  // withdrawall
  //await bankContract.withdrawall();

  // withdraw
  await bankContract.withdraw();

  num = await bankContract.getBalance(selectAddress)
  log("withdraw end ETH:", ethers.utils.formatEther(num));

  balancecount = await bankContract.getAllBalance();
  log("withdraw end Bank all balance:", ethers.utils.formatEther(balancecount));

}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });