//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "./ProphetweetToken.sol";

abstract contract AbstractMerkleDistributer is
    AccessControlEnumerable,
    ReentrancyGuard
{
    bytes32 public constant MODERATOR_ROLE = keccak256("MODERATOR_ROLE");

    ProphetweetToken public token;

    event Claim(
        address indexed to,
        address indexed twitterHashId, 
        uint256 version,
        uint256 amount
    );

    modifier onlyAdminOrModeratorRoles() {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, _msgSender()) ||
                hasRole(MODERATOR_ROLE, _msgSender()),
            "Not admin or moderator"
        );
        _;
    }

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function claim(
        uint256 version,
        address to,
        address twitterIdHash,
        uint256 amount,
        bytes32[] calldata proof
    ) external virtual;
}
