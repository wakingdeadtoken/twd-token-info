// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract TWDToken is ERC20, ERC20Burnable, AccessControl, ReentrancyGuard {
    
    bytes32 public constant GAME_ROLE = keccak256("GAME_ROLE");
    bytes32 public constant TREASURY_ROLE = keccak256("TREASURY_ROLE");

    constructor(address initialOwner) ERC20("The Waking Dead", "TWD") {
        _grantRole(DEFAULT_ADMIN_ROLE, initialOwner);
        _mint(initialOwner, 1_000_000_000 * 10 ** decimals());
    }

    function gameTransfer(address from, address to, uint256 amount)
        public
        nonReentrant
        onlyRole(GAME_ROLE)
    {
        _transfer(from, to, amount);
    }

    function gameBurn(address from, uint256 amount)
        public
        nonReentrant
        onlyRole(GAME_ROLE)
    {
        _burn(from, amount);
    }

    function hasGameRole(address account) external view returns (bool) {
        return hasRole(GAME_ROLE, account);
    }
}
