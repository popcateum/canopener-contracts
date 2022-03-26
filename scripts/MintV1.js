const hre = require("hardhat");

async function main() {
  const nft = "0x6C7739C6bFf4f51174484a7fe74Ad04B7d14fd76";
  const devAddress = "0xca027Fe02ff3aEa8dB89Aeb8aB2a5d08ceE3ddb8";
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
