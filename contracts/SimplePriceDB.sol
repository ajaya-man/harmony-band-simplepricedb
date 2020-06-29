pragma solidity 0.5.14;
pragma experimental ABIEncoderV2;

import {IBridge} from "./interface/IBridge.sol";
import {ParamsDecoder, ResultDecoder} from "./lib/Decoders.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract SimplePriceDB {
    using SafeMath for uint256;
    using ResultDecoder for bytes;
    using ParamsDecoder for bytes;

    IBridge public bridge;
    uint256 public price;

    constructor(
        IBridge bridge_
    ) public {
        bridge = bridge_;
    }

    function verifyAndSavePrice(bytes memory _data) public {
        (
            IBridge.RequestPacket memory latestReq,
            IBridge.ResponsePacket memory latestRes
        ) = bridge.relayAndVerify(_data);

        ParamsDecoder.Params memory params = latestReq.params.decodeParams();
        uint64 oracleScriptID = latestReq.oracleScriptId;
        ResultDecoder.Result memory result = latestRes.result.decodeResult();
        uint64 resolveTime = latestRes.resolveTime;

        // Check for correct oracleScriptID
        require(
            oracleScriptID ==
                1,
            "ERROR_ORACLE_SCRIPT_ID_DOES_NOT_MATCH_WITH_EXPECTED"
        );
        // Check for correct request parameters
        require(
            keccak256(abi.encode(params.symbol)) ==
                keccak256(abi.encode("BTC")),
            "ERROR_SYMBOL_DOES_NOT_MATCH_WITH_EXPECTED"
        );
        require(
            params.multiplier ==
                100,
            "ERROR_MULTIPLIER_DOES_NOT_MATCH_WITH_EXPECTED"
        );
        // Check that the request resolve time is not too long ago
        require(
            resolveTime - now < 100 || now - resolveTime < 100,
            "ERROR_MULTIPLIER_DOES_NOT_MATCH_WITH_EXPECTED"
        );
        price = uint256(result.px);
    }
}