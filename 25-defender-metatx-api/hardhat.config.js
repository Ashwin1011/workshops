require('dotenv').config();

require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");

task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    local: {
      url: 'http://localhost:8545'
    },
    goerli: {
      url: 'https://rpc.goerli.mudit.blog',
      accounts: [process.env.PRIVATE_KEY],
    },
    mumbai: {
      url: 'https://rpc-mumbai.maticvigil.com/v1/7ed9db516896286a59aac0ec886f2e12e8cbf06e',
      accounts: [process.env.PRIVATE_KEY],
    },
  }
};
