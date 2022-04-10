//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CommitReveal {
    mapping(address => bytes32) public voteByUser;
    mapping(string => uint256) public voteCounts;

    constructor() {
        console.log("Deploying CommitReveal contract");
    }

    // commit a vote by passing in the keccak256 hash of
    // the vote and salt
    function commitVote(bytes32 _secretVote) external {
        voteByUser[msg.sender] = _secretVote;
    }

    // reveal a vote by providing the original vote and the salt
    function revealVote(string memory _vote, string memory _salt) external {
        require(keccak256(abi.encodePacked(_vote, _salt)) == voteByUser[msg.sender],
            "vote and salt do not match stored hash");
        voteCounts[_vote] += 1;
    }

    // performs keccak256 hash on two strings
    function getHash(string memory _foo, string memory _bar) pure external returns (bytes32){
        return keccak256(abi.encodePacked(_foo, _bar));
    }
}
