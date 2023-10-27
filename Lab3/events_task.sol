// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventContract {
    address public owner;
    uint256 public data;
    address public lastUpdatedBy;

    event DataUpdated(address indexed user, uint256 newValue);

    constructor() {
        owner = msg.sender;
        data = 0;
        lastUpdatedBy = address(0);
    }

    function updateData(uint256 newValue) public {
        data = newValue;
        lastUpdatedBy = msg.sender;
        emit DataUpdated(msg.sender, newValue);
    }

    function getData() public view returns (uint256) {
        return data;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getLastUpdatedBy() public view returns (address) {
        return lastUpdatedBy;
    }
}
