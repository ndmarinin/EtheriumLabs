// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./TokenA.sol";
import "./TokenB.sol";

contract Exchange {
    address public owner;
    TokenA tokenA;
    TokenB tokenB;
    uint256 public tokenAPerTokenB = 2;

    event ExchangeTokens(
        address exchanger,
        uint256 amountOfTokenA,
        uint256 amountOfTokenB
    );

    constructor(address _tokenA, address _tokenB) {
        tokenA = TokenA(_tokenA);
        tokenB = TokenB(_tokenB);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    function exchangeAforB(uint256 _amount) public payable {
        require(_amount > 0, "You need to exchange some TokenA to proceed");
        uint256 amountToReceive = _amount * tokenAPerTokenB;

        uint256 exchangeBalance = tokenB.balanceOf(address(this));
        require(
            exchangeBalance >= amountToReceive,
            "Exchange has insufficient TokenB"
        );

        bool sent = tokenA.transferFrom(msg.sender, address(this), _amount);
        require(sent, "Failed to transfer TokenA from user");

        sent = tokenB.transfer(msg.sender, amountToReceive);
        require(sent, "Failed to transfer TokenB to user");

        emit ExchangeTokens(msg.sender, _amount, amountToReceive);
    }

    function exchangeBforA(uint256 _amount) public payable {
        require(_amount > 0, "You need to exchange some TokenB to proceed");
        uint256 amountToReceive = _amount / tokenAPerTokenB;

        uint256 exchangeBalance = tokenA.balanceOf(address(this));
        require(
            exchangeBalance >= amountToReceive,
            "Exchange has insufficient TokenA"
        );

        bool sent = tokenB.transferFrom(msg.sender, address(this), _amount);
        require(sent, "Failed to transfer TokenB from user");

        sent = tokenA.transfer(msg.sender, amountToReceive);
        require(sent, "Failed to transfer TokenA to user");

        emit ExchangeTokens(msg.sender, amountToReceive, _amount);
    }
}
