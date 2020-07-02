const SimplePriceDB = artifacts.require("SimplePriceDB");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(SimplePriceDB, "0x0671E9734bDE19eb744Df3f80FAba52a0994b1F4" );
};
