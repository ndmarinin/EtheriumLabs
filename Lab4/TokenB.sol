// SPDX-License-Identifier: MIT
import "./BaseERC.sol";


pragma solidity ^0.8.0;


contract TokenB is ERC20 {
    address public minter;
    uint constant _one_token = 10**18;

    event Mint(address indexed to, uint256 amount);

    constructor() ERC20("TokenB", "TKB") {
        _mint(msg.sender, 100 * _one_token);
        minter = msg.sender;
    }

    modifier onlyMinter() {
        require(msg.sender == minter, "Only minter can mint tokens");
        _;
    }

    function mint(uint256 amount) public onlyMinter {
        _mint(msg.sender, amount * _one_token);
        emit Mint(msg.sender, amount * _one_token);
    }

    function mintTo(address to, uint256 amount) public onlyMinter {
        _mint(to, amount * _one_token);
        emit Mint(to, amount * _one_token);
    }
}
