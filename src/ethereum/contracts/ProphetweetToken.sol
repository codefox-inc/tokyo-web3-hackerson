// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ProphetweetToken is ERC1155, Ownable {
    uint256 public NFTPrice;
    uint256 public NFTId;

    constructor(uint256 _NFTPrice) ERC1155("TrialToken") {
        NFTPrice = _NFTPrice;
    }

    function mintNFT(address account, bytes memory data)
        public
        onlyOwner
        returns(bool)
    {
        _mint(account, ++NFTId, 1, data);
        return true;
    }

    function mintToken(address account, uint256 amount, bytes memory data)
        public
        onlyOwner
        returns(bool)
    {
        _mint(account, 0, amount, data);
        return true;
    }

    function burn(address account, uint256 id, uint256 amount)
        public
        onlyOwner
        returns(bool)
    {
        _burn(account, id, amount);
        return true;
    }

    function buyNFT() public returns(bool) {
        address sender = _msgSender();
        require(balanceOf(sender, 0) >= NFTPrice, "No available balance");
        _burn(sender, 0, NFTPrice);
        _mint(sender, 1, 1, "0x");
        return true;
    }

    function setNFTPrice(uint256 _NFTPrice) public onlyOwner {
        NFTPrice = _NFTPrice;
    }
}