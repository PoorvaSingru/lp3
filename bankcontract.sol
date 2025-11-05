// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title SimpleBank - deposit, withdraw, show balances (for learning / testnets)
contract SimpleBank {
    // mapping of customer address => balance (in wei)
    mapping(address => uint256) private balances;

    // Events
    event Deposit(address indexed who, uint256 amount);
    event Withdraw(address indexed who, uint256 amount);
    event OwnerWithdraw(address indexed owner, uint256 amount);

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    /// @notice Deposit ETH to your bank account (payable)
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH to deposit");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    /// @notice Withdraw `amount` wei from caller's account
    /// @param amount Amount in wei to withdraw
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdraw amount must be > 0");
        uint256 bal = balances[msg.sender];
        require(bal >= amount, "Insufficient balance");

        // Update state before transfer (checks-effects-interactions)
        balances[msg.sender] = bal - amount;

        // Transfer ETH to the caller (use call for safety)
        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Transfer failed");

        emit Withdraw(msg.sender, amount);
    }

    /// @notice Returns caller's balance (in wei)
    function getMyBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    /// @notice Returns any account's stored balance (in wei)
    function getBalanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    /// @notice Returns the contract's ETH balance (total deposits not withdrawn)
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /// @notice (Optional) Owner can withdraw accidentally stuck funds not accounted to users.
    /// Use this with care — only owner can call.
    function ownerWithdraw(uint256 amount) external {
        require(msg.sender == owner, "Only owner");
        require(address(this).balance >= amount, "Insufficient contract balance");

        (bool ok, ) = payable(owner).call{value: amount}("");
        require(ok, "Transfer failed");

        emit OwnerWithdraw(owner, amount);
    }

    // Fallback/receive to reject plain transfers (optional) — prefer using deposit()
    receive() external payable {
        // If someone sends ETH directly, credit them
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
}
