const SimplePriceDB = artifacts.require("SimplePriceDB");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(SimplePriceDB, "0x615c5AA5d1eEe542EeFC6f3A8BF7e1A38A7B219b" );
};
