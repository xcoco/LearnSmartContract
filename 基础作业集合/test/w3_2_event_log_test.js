const { log } = require("console");
const { ethers } = require("hardhat");
const fs = require('fs');
const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('.chifan.db');

const MointorAddress = "0x4826533B4897376654Bb4d4AD88B7faFD0C98528";

async function saveDataToDB (dataEvent) {
  log("from :", dataEvent.from, " to:", dataEvent.to, " tokenid:", dataEvent.tokenId.toNumber());
  let insertQuery = `insert into erc721_transfer(from_address, to_address, token_id) values('${dataEvent.from}', '${dataEvent.to}', ${dataEvent.tokenId.toNumber()})`;
  let sqlquery = db.prepare(insertQuery);
  sqlquery.run();
}


async function main () {
  let crateTableQuery = "create table if not exists erc721_transfer(from_address TEXT, to_address TEXT, token_id INTEGER);";
  db.run(crateTableQuery);
  let [owner, second] = await ethers.getSigners();
  let chifan721 = await ethers.getContractAt("ChiFan721", MointorAddress, owner);
  log("owner:", owner.address, " erc721 address:", chifan721.address);
  let filter = {
    address: chifan721.address,
    topics: [ethers.utils.id("Transfer(address,address,uint256)")]
  }

  ethers.provider.on(filter, async (event) => {
    let decodeEvent = chifan721.interface.decodeEventLog("Transfer", event.data, event.topics);
    await saveDataToDB(decodeEvent);
  });

}



main()