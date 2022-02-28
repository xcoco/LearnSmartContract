const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy();
    await greeter.deployed();

    const setGreetingTx = await greeter.setCounter(1024);

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.GetCounter()).to.equal("1024");

    console.log(await greeter.GetCounter());
  });
});
