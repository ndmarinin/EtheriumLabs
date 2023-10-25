// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RockPaperScissors {
    enum Hand { Nothing, Rock, Paper, Scissors }
    mapping(address => Hand) private hands;
    address public player1;
    address public player2;

    constructor() {
        player1 = msg.sender;
    }

    function joinGame() public {
        require(msg.sender != address(0));
        player2 = msg.sender;
    }

    function play(Hand hand) public {
        require(msg.sender == player1 || msg.sender == player2);
        hands[msg.sender] = hand;
    }

    function judge() public view returns (string memory) {
        require(player1 != address(0) && player2 != address(0));
        require(hands[player1] != Hand.Nothing && hands[player2] != Hand.Nothing);

        if (hands[player1] == hands[player2]) return "draw";
        if (hands[player1] == Hand.Rock && hands[player2] == Hand.Scissors) return "Player 1 win";
        if (hands[player1] == Hand.Paper && hands[player2] == Hand.Rock) return "Player 1 win";
        if (hands[player1] == Hand.Scissors && hands[player2] == Hand.Paper) return "Player 1 win";
        return "Player 2 win";
    }
}
