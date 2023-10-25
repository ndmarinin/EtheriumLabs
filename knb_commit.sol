// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RockPaperScissors {
    enum Hand { None, Rock, PaБуper, Scissors }
    mapping(address => bytes32) private commitments;
    mapping(address => Hand) private hands;
    address public player1;
    address public player2;

    constructor() {
        player1 = msg.sender;
        hands[player1] = Hand.None;
    }

    function joinGame() public {
        require(msg.sender != address(0));
        player2 = msg.sender;
        hands[player2] = Hand.None;
    }

    function commit(bytes32 commitment) public {
        require(msg.sender == player1 || msg.sender == player2);
        commitments[msg.sender] = commitment;
    }

    function reveal(Hand hand, string memory secret) public {
        require(msg.sender == player1 || msg.sender == player2);
        if (keccak256(abi.encode(hand, secret)) == commitments[msg.sender]) {
            hands[msg.sender] = hand;
        }
    }

    function resetGame() public {
        require(msg.sender == player1 || msg.sender == player2);
        delete commitments[player1];
        delete commitments[player2];
        hands[player1] = Hand.None;
        hands[player2] = Hand.None;
    }

    function judge() public view returns (string memory) {
        require(player1 != address(0) && player2 != address(0));
        if (hands[player1] == Hand.None || hands[player2] == Hand.None) return "One or both players have not made a choice";
        if (hands[player1] == hands[player2]) return "draw";
        if (hands[player1] == Hand.Rock && hands[player2] == Hand.Scissors) return "Player 1 win";
        if (hands[player1] == Hand.Paper && hands[player2] == Hand.Rock) return "Player 1 win";
        if (hands[player1] == Hand.Scissors && hands[player2] == Hand.Paper) return "Player 1 win";
        return "Player 2 win";
    }
}
