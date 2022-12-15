// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Jokes {
    uint256 public totalJokes;

    // new joke event to be fired when new joke is added
    event NewJoke(address indexed from, uint256 timestamp, string joke);

    // data structure of a Joke item
    struct Joke {
        address joker;
        string joke;
        uint256 timestamp;
    }

    // an array of all jokes
    Joke[] allJokes;

    receive() external payable {}

    function newJoke(string memory _joke) public payable {
        // bumps the count of total jokes told to the Jokes smart contract
        totalJokes += 1;

        // adds the joke to list with all previous jokes
        allJokes.push(Joke(msg.sender, _joke, block.timestamp));

        // emits a new event for new joke
        emit NewJoke(msg.sender, block.timestamp, _joke);

        // paying some ether to the joker
        uint256 prizeAmount = 0.01 ether;
        require(
            prizeAmount <= address(this).balance,
            "Out of ether, try again later"
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to pay the joker!");
    }

    // function to get all the jokes told to till now
    function getAllJokes() public view returns (Joke[] memory) {
        return allJokes;
    }

    // function to get count of all jokes told to till now
    function getTotalJokes() public view returns (uint256) {
        return totalJokes;
    }
}
