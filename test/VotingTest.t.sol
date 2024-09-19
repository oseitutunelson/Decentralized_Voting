 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.23;

 import {Test} from "forge-std/Test.sol";
 import {Voting} from "../src/voting.sol";
 import {console} from 'forge-std/console.sol';

contract VotingTest is Test{
    Voting public voting;

    address public owner = address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    address voter1 = makeAddr('voter1');
    address voter2 = makeAddr('voter2');

    function setUp() public{
        vm.prank(owner);
        voting = new Voting();
        console.log(owner);
        console.log(msg.sender);
    }

    //test add candidate
    function testAddCandidate() public {
        vm.prank(msg.sender);
        voting.addCandidate("Candidate 1");
        console.log(msg.sender);
        
        (string memory name, uint noOfVotes) = voting.getCandidate(0);
        assertEq(name, "Candidate 1");
        assertEq(noOfVotes, 0);
    }

    //test start voting

    function testStartVoting() public {
        // Start the voting process with a duration of 10 seconds
        vm.prank(msg.sender);
        voting.startVoting(10);

        // Verify voting has started
        assertTrue(voting.isVotingActive());
        assertEq(voting.getVotingEndTime(), block.timestamp + 10);
    }

    //test voting process
    function testVoting() public {
        // Add candidates
        vm.prank(msg.sender);
        voting.addCandidate("Candidate 1");
        
        vm.prank(msg.sender);
        voting.addCandidate("Candidate 2");

        // Start voting
        vm.prank(msg.sender);
        voting.startVoting(60);

        // Vote for Candidate 1 as voter1
        vm.prank(voter1);
        voting.vote(0);
        
        // Check the vote count
        (string memory name, uint noOfVotes) = voting.getCandidate(0);
        assertEq(noOfVotes, 1);

        // Ensure voter1 cannot vote again
        vm.expectRevert("Address has already voted");
        vm.prank(voter1);
        voting.vote(0);

        // Vote for Candidate 2 as voter2
        vm.prank(voter2);
        voting.vote(1);

        // Check the vote count
        (, noOfVotes) = voting.getCandidate(1);
        assertEq(noOfVotes, 1);
    }

    //test cannot vote before voting starts
    function testCannotVoteBeforeVotingStarts() public {
        // Add candidate
        vm.prank(msg.sender);
        voting.addCandidate("Candidate 1");

        // Attempt to vote before voting starts
        vm.expectRevert("Voting has not started yet");
        vm.prank(voter1);
        voting.vote(0);
    }
  
    //test cannot vote after voting ends
    function testCannotVoteAfterVotingEnds() public {
        // Add candidates
        vm.prank(msg.sender);
        voting.addCandidate("Candidate 1");

        // Start and end voting
        vm.prank(msg.sender);
        voting.startVoting(1); // Voting duration is 1 second

        vm.warp(block.timestamp + 2); // Fast forward time to simulate voting end

        // Attempt to vote after voting ends
        vm.expectRevert("Voting period has ended");
        vm.prank(voter1);
        voting.vote(0);
    }
   
   //test end voting
    function testEndVoting() public {
        // Add candidates
        vm.prank(msg.sender);
        voting.addCandidate("Candidate 1");
        vm.prank(msg.sender);
        voting.addCandidate("Candidate 2");

        // Start and end voting
        vm.prank(msg.sender);
        voting.startVoting(3600);

        // Vote as different users
        vm.prank(voter1);
        voting.vote(0); // Vote for Candidate 1
        vm.prank(voter2);
        voting.vote(1); // Vote for Candidate 2

        // End voting after the period
        vm.warp(block.timestamp + 3601); // Fast forward past the voting period
        vm.prank(msg.sender);
        voting.endVoting();

        // Declare winner
        (string memory winnerName, uint winnerVotes) = voting.declareWinner();
        assertEq(winnerVotes, 1); // Both candidates have 1 vote, so first added wins
        assertEq(winnerName, "Candidate 1");
    }

     
     //test change owner
    function testChangeOwner() public {
        address newOwner = makeAddr('newOwner');

        // Change owner
        vm.prank(msg.sender);
        voting.changeOwner(newOwner);

        // Ensure new owner is set
        assertEq(voting.getOwner(), newOwner);
    }

}
