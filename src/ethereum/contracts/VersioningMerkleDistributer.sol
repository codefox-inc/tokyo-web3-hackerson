//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "./AbstractMerkleDistributer.sol";

contract VersioningMerkleDistributer is AbstractMerkleDistributer {
    struct Detail {
        mapping(address => bool) hasClaimed;
        bytes32 merkleRoot;
    }

    uint256 public currentVersion; // default value is 0
    mapping(uint256 => Detail) public versionToDetailMap;

    constructor (address initialToken, bytes32 initialMerkleRoot)
    {
        token = ProphetweetToken(initialToken);
        currentVersion = currentVersion + 1;
        versionToDetailMap[currentVersion].merkleRoot = initialMerkleRoot;
    }

    function setMerkleRoot(bytes32 newMerkleRoot)
        public
        onlyOwner
    {
        currentVersion = currentVersion + 1;
        versionToDetailMap[currentVersion].merkleRoot = newMerkleRoot;
    }

    function setCurrentVersion(uint256 nextVersion)
        public
        onlyOwner
    {
        require(nextVersion > 0, "Invalid version info");

        currentVersion = nextVersion;
    }

    function claim(
        uint256 version,
        address to,
        address twitterIdHash,
        uint256 amount,
        bytes32[] calldata proof
    )   external
        onlyOwner
        override nonReentrant
    {
        (bool isClaimable, string memory message) = getIsClaimable(
            version,
            twitterIdHash,
            amount,
            proof
        );
        require(isClaimable, message);

        versionToDetailMap[currentVersion].hasClaimed[twitterIdHash] = true;
        require(token.mintToken(to, amount, "0x"), "Mint failed");

        emit Claim(to, twitterIdHash, version, amount);
    }

    function getIsClaimable(
        uint256 version,
        address recipient,
        uint256 amount,
        bytes32[] calldata proof
    ) public view returns (bool, string memory) {
        if (versionToDetailMap[version].hasClaimed[recipient]) {
            return (false, "Recipient already claimed");
        }

        bytes32 leaf = keccak256(abi.encodePacked(recipient, amount));
        bool isValidLeaf = MerkleProof.verify(
            proof,
            versionToDetailMap[version].merkleRoot,
            leaf
        );
        if (!isValidLeaf) {
            return (false, "Not a valid leaf");
        }

        return (true, "Reward is claimable");
    }
}