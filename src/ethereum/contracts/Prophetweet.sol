//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VersioningMerkleDistributer.sol";

contract Prophetweet is VersioningMerkleDistributer {
    uint256 public trialNumber;

    event Trial(
        address indexed executer, 
        uint256 indexed tokenId, 
        string twitterId,
        string tweetNumber,
        uint256 trialNumber
    );

    constructor (address initialToken, bytes32 initialMerkleRoot)
        VersioningMerkleDistributer(initialToken, initialMerkleRoot) {}

    function setNFTPrice(uint256 _NFTPrice)
        public
        onlyAdminOrModeratorRoles
    {
        token.setNFTPrice(_NFTPrice);
    }

    function trial(uint256 id, string memory twitterId, string memory tweetNumber) public {
      require(id != 0, "not NFT");
      address sender = _msgSender();
      require(token.balanceOf(sender, id) >= 1, "No available balance");
      token.burn(sender, id, 1);
      emit Trial(sender, id, twitterId, tweetNumber, ++trialNumber);
    }
}
