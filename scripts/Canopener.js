const hre = require("hardhat");

async function main() {
  const uri = 'ipfs://QmetiXt19bqojRmQKguASGJpTMcWjWPbrpdRrUjVU3C7Ns/'
  const amount = '10001'

  const Canopener = await hre.ethers.getContractFactory("Canopener");
  const canopener = await Canopener.deploy(uri, amount);

  await canopener.deployed();

  console.log("Canopener deployed to:", canopener.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
