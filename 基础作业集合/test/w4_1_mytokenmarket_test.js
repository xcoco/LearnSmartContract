const { log } = require("console");
const { ethers } = require("hardhat");

const MyTokenMarketAddress = "0x856bE00e6da147843294F0E66cC65C89a47abFcD";
const MytokenAddress = "0xfd87Dd715d164c486f27E518a083687E509810EE";

async function main () {
  let [owner, second] = await ethers.getSigners();
  let MyTokenMarket = await ethers.getContractFactory("MyTokenMarket");
  let mytokenmarket = await MyTokenMarket.attach(MyTokenMarketAddress);

  let ChiFanToken = await ethers.getContractFactory("ChiFanToken");
  chifanErc20Contract = ChiFanToken.attach(MytokenAddress);
  log("ChiFanToken Contract address:", chifanErc20Contract.address);

  let currentwallet = owner.address;
  log("Current Wallet address:", currentwallet);

  // 增发
  await chifanErc20Contract.AddToken(currentwallet, ethers.utils.parseEther("10001"));
  let balance = await chifanErc20Contract.balanceOf(currentwallet);
  log("增发 balance:", ethers.utils.formatEther(balance));

  // ERC20 授权给 MyTokenMarket
  await chifanErc20Contract.approve(MyTokenMarketAddress, ethers.utils.parseEther("1000"));

  // 添加流动性
  let options = {
    value: ethers.utils.parseEther("0.1"),
    gasLimit: 4000000,
    gasPrice: ethers.utils.parseUnits("60", "gwei")
  };

  await mytokenmarket.AddLiquidity(ethers.utils.parseEther("1000"), options);
  balance = await chifanErc20Contract.balanceOf(currentwallet);
  log("添加流动性后 balance:", ethers.utils.formatEther(balance));

  // 购买token
  await mytokenmarket.BuyToken(1, options);
  balance = await chifanErc20Contract.balanceOf(currentwallet);
  log("购买token后 balance:", ethers.utils.formatEther(balance));

}

main()