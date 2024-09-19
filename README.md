# Decentralized Voting Smart Contract

## Overview

This is a decentralized voting smart contract written in Solidity. The contract allows users to create candidates, vote for their preferred candidate, and declares the winner once the voting period ends. It utilizes Chainlink Automation for automatically declaring the winner when the voting time elapses. This contract is designed to be flexible and secure, with functionality to start, stop, and automate the voting process.

## Features

   - Candidate Management: Only the contract owner can add candidates.
   - Voting Process: Voters can vote for their preferred candidate once the voting has started.
   - Voting Time Management: The owner sets the duration for voting. Votes are accepted only within the active voting period.
   - Chainlink Automation: Automatically checks when voting ends and declares the winner.
   - Security: Ensures that:
       * Only one vote per voter is allowed.
       * Only the owner can start and end the voting process.
       * Voting cannot happen before the voting process starts or after it ends.

## Contract Details
1. Owner Functions

   - addCandidate(string memory name): Adds a candidate to the list of candidates (only callable by the owner).

   - startVoting(uint durationInSeconds): Starts the voting process and sets the duration in seconds (only callable by the owner).

   - endVoting(): Manually ends the voting process (only callable by the owner).

   - changeOwner(address newOwner): Transfers ownership of the contract to a new owner.       

2. Voting Functions

   - vote(uint id): Allows a voter to vote for a candidate by their id. Each voter can only vote once.

   - declareWinner(): Declares the winner after the voting period has ended. Returns the candidate's name and vote count.

3. Automation (Chainlink) Functions

   - checkUpkeep(bytes memory): Checks if the voting period has ended and determines if upkeep is needed.

   - performUpkeep(bytes calldata): Automatically declares the winner if the voting period has ended.   

## Events

   - CandidateCreated(uint indexed candidateNo, string indexed candidateName): Emitted when a new candidate is created.

   - Voted(uint indexed id): Emitted when a voter votes for a candidate.

   - OwnerChange(address indexed oldOwner, address indexed newOwner): Emitted when the contract owner changes.

   - VotingStarted(uint endTime): Emitted when the voting process starts.

   - VotingEnded(string winnerName, uint winnerVotes): Emitted when voting ends and the winner is declared.   

Decentralized Voting Smart Contract
Overview

This is a decentralized voting smart contract written in Solidity. The contract allows users to create candidates, vote for their preferred candidate, and declares the winner once the voting period ends. It utilizes Chainlink Automation for automatically declaring the winner when the voting time elapses. This contract is designed to be flexible and secure, with functionality to start, stop, and automate the voting process.
Author:

Owusu Nelson Osei Tutu
Features

    Candidate Management: Only the contract owner can add candidates.
    Voting Process: Voters can vote for their preferred candidate once the voting has started.
    Voting Time Management: The owner sets the duration for voting. Votes are accepted only within the active voting period.
    Chainlink Automation: Automatically checks when voting ends and declares the winner.
    Security: Ensures that:
        Only one vote per voter is allowed.
        Only the owner can start and end the voting process.
        Voting cannot happen before the voting process starts or after it ends.

Contract Details
1. Owner Functions

    addCandidate(string memory name): Adds a candidate to the list of candidates (only callable by the owner).

    startVoting(uint durationInSeconds): Starts the voting process and sets the duration in seconds (only callable by the owner).

    endVoting(): Manually ends the voting process (only callable by the owner).

    changeOwner(address newOwner): Transfers ownership of the contract to a new owner.

2. Voting Functions

    vote(uint id): Allows a voter to vote for a candidate by their id. Each voter can only vote once.

    declareWinner(): Declares the winner after the voting period has ended. Returns the candidate's name and vote count.

3. Automation (Chainlink) Functions

    checkUpkeep(bytes memory): Checks if the voting period has ended and determines if upkeep is needed.

    performUpkeep(bytes calldata): Automatically declares the winner if the voting period has ended.

Events

    CandidateCreated(uint indexed candidateNo, string indexed candidateName): Emitted when a new candidate is created.

    Voted(uint indexed id): Emitted when a voter votes for a candidate.

    OwnerChange(address indexed oldOwner, address indexed newOwner): Emitted when the contract owner changes.

    VotingStarted(uint endTime): Emitted when the voting process starts.

    VotingEnded(string winnerName, uint winnerVotes): Emitted when voting ends and the winner is declared.

# Deployment & Testing
## Deployment

To deploy the contract:

    Install Foundry.
    Compile the contract using:

    `forge build`
      
Deploy the contract on a supported Ethereum network (testnets like Sepolia or mainnet).   

## Testing

You can run tests using Foundry:

    Write tests in the test/ folder.
    Run the tests using:

    

    `forge test`

