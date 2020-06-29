const SimplePriceDB = artifacts.require("SimplePriceDB");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(SimplePriceDB, "0x96Ab34Bda8414f329604a151d89982B19C680c17" );
};
