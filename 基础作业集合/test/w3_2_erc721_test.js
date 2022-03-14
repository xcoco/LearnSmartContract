const { log } = require("console");
const { ethers } = require("hardhat");


const MointorAddress = "0x4826533B4897376654Bb4d4AD88B7faFD0C98528";
const ToAddress = "0x70997970c51812dc3a010c7d01b50e0d17dc79c8"

async function main () {
  let [owner, second] = await ethers.getSigners();
  let ChiFanToken = await ethers.getContractFactory("ChiFan721");
  let chifanErc721Contract = ChiFanToken.attach(MointorAddress);

  let balance = await chifanErc721Contract.balanceOf(owner.address);
  log("balance:", balance);
  if (balance.eq(0)) {
    await chifanErc721Contract.PublicMint();
  }
  let tokenid = await chifanErc721Contract.GetTokenId(owner.address);
  log("ERC721 token:", tokenid.toNumber());
  balance = await chifanErc721Contract.balanceOf(MointorAddress);
  log("ERC721 Me balance:", balance);
  balance = await chifanErc721Contract.balanceOf(ToAddress);
  log("ERC721 To balance:", balance);


  await chifanErc721Contract.SafeTransfer(ToAddress, tokenid.toNumber());

  balance = await chifanErc721Contract.balanceOf(MointorAddress);
  log("transferFromed ERC721 Me balance:", balance);
  balance = await chifanErc721Contract.balanceOf(ToAddress);
  log("transferFromed ERC721 To balance:", balance);

}

main()