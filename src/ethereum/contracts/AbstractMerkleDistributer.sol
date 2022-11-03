//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ProphetweetToken.sol";

abstract contract AbstractMerkleDistributer is
    Ownable,
    ReentrancyGuard
{
    ProphetweetToken public token;

    event Claim(
        address indexed to,
        address indexed twitterHashId, 
        uint256 version,
        uint256 amount
    );

    function claim(
        uint256 version,
        address to,
        address twitterIdHash,
        uint256 amount,
        bytes32[] calldata proof
    ) external virtual;
}
