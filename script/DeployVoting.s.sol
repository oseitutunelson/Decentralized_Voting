//SPDX-License-Identifier:MIT

pragma solidity ^0.8.23;

import {Voting} from "../src/voting.sol";
import {Script} from "forge-std/Script.sol";

contract DeployVoting is Script{
    function run() external returns (Voting) {
        vm.startBroadcast();
        Voting voting = new Voting();
        vm.stopBroadcast();
        return voting;
    }
}
