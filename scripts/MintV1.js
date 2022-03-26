const hre = require("hardhat");

async function main() {
  const nft = "0x";
  const devAddress = "0x";
  const isMint = false;

  const MintV1 = await hre.ethers.getContractFactory("MintV1");
  const mintV1 = await MintV1.deploy(nft, devAddress, isMint);

  await mintV1.deployed();

  console.log("MintV1 deployed to:", mintV1.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
