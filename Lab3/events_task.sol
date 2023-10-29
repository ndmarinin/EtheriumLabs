// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventContract {
    address private owner;
    uint256 private data;
    address private lastUpdatedBy;

    event DataUpdated(address indexed user, uint256 newValue);
    event ValueIsZero(address indexed user);

    constructor() {
        owner = msg.sender;
        data = 0;
        lastUpdatedBy = address(0);
    }

    function updateData(uint256 newValue) public {
        data = newValue;
        lastUpdatedBy = msg.sender;
        emit DataUpdated(msg.sender, newValue);
        if (data == 0) {
            emit ValueIsZero(msg.sender);
        }
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
