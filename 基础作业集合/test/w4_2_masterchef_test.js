const { log } = require("console");
const { ethers } = require("hardhat");

const MyTokenMarketAddress = "0x80ad3a2BB9bC2EbEe7951ECe82D493fbF0a2D7Cb";
const MytokenAddress = "0xE003bCB637c3f290227E68a414c40f03a3909ef7";
const MasterChefAddress = "0x00DE7cfcF928eadE7bfe985CE0Ec6f086fd3538d";
const ShushiTtokenAddress = "0xc23b98723268418bB630B37251A8536585945661";

async function main () {
  let [owner, second] = await ethers.getSigners();
  let MyTokenMarket = await ethers.getContractFactory("MyTokenMarket");
  let mytokenmarket = await MyTokenMarket.attach(MyTokenMarketAddress);

  let ShushiTtoken = await ethers.getContractFactory("SushiToken");
  let shushitoken = await ShushiTtoken.attach(ShushiTtokenAddress);

  let ChiFanToken = await ethers.getContractFactory("ChiFanToken");
  chifanErc20Contract = ChiFanToken.attach(MytokenAddress);
  log("ChiFanToken Contract address:", chifanErc20Contract.address);

  let MasterChef = await ethers.getContractFactory("MasterChef");
  let masterchef = await MasterChef.attach(MasterChefAddress);
  log("MasterCheft address:", masterchef.address);

  let currentwallet = owner.address;
  log("Current Wallet address:", currentwallet);

  let gaslimitOption = {
    gasLimit: 4000000,
    gasPrice: ethers.utils.parseUnits("60", "gwei")
  };

  // Withdraw
  //await mytokenmarket.MasterChefWithdraw(ethers.utils.parseEther("200"), gaslimitOption);
  //return;


  //修改sushitoken owner 为 masterchef
  //await shushitoken.transferOwnership(masterchef.address, gaslimitOption);


  // 增发
  await chifanErc20Contract.AddToken(currentwallet, ethers.utils.parseEther("10001"), gaslimitOption);
  let balance = await chifanErc20Contract.balanceOf(currentwallet);
  log("增发 balance:", ethers.utils.formatEther(balance));

  // 添加pool
  await masterchef.add(1024, chifanErc20Contract.address, true, {
    gasLimit: 4000000,
    gasPrice: ethers.utils.parseUnits("60", "gwei")
  });



  // 添加流动性
  let options = {
    value: ethers.utils.parseEther("0.1"),
    gasLimit: 4000000,
    gasPrice: ethers.utils.parseUnits("60", "gwei")
  };



  // ERC20 授权给 MyTokenMarket
  await chifanErc20Contract.approve(MyTokenMarketAddress, ethers.utils.parseEther("1000"));

  await mytokenmarket.AddLiquidity(ethers.utils.parseEther("1000"), options);
  balance = await chifanErc20Contract.balanceOf(currentwallet);
  log("添加流动性后 balance:", ethers.utils.formatEther(balance));


  await mytokenmarket.BuyToken(1, options);
  balance = await chifanErc20Contract.balanceOf(currentwallet);
  log("购买token后 balance:", ethers.utils.formatEther(balance));

}

main()