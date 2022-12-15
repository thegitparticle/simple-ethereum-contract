// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Jokes.sol";

contract JokesTest is Test {
    function testNewJoke() public {
        Jokes jokes = new Jokes();
        jokes.newJoke("How does a computer get drunk? It takes screen shots.");
        assertEq(jokes.totalJokes(), 1);
    }
}
