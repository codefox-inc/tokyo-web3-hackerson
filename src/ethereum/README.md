# API
## PropheteetToken.sol
### mintNFT
```solidity
    function mintNFT(address account, bytes memory data)
        public
        onlyOwner
        returns(bool)
    {
        _mint(account, ++NFTId, 1, data);
        return true;
    }
```
ownerは質問NFTを自由に作れます。
### buyNFT
```solidity
    function buyNFT() public returns(bool) {
        address sender = _msgSender();
        require(balanceOf(sender, 0) >= NFTPrice, "No available balance");
        _burn(sender, 0, NFTPrice);
        _mint(sender, ++NFTId, 1, "0x");
        return true;
    }
```
誰でも正解トークンで質問NFTを買えます。

## Prophetweet.sol
### trial
```solidity
    function trial(uint256 id, string memory twitterId, string memory tweetNumber) public {
        require(id != 0, "not NFT");
        address sender = _msgSender();
        require(token.balanceOf(sender, id) >= 1, "No available balance");
        token.burn(sender, id, 1);
        emit Trial(sender, id, twitterId, tweetNumber, ++trialNumber);
    }
```
質問NFTをバーンしてイベントを発火する。
### claim
```solidity
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
```
ownerはマークルルートから正解トークンを誰かに与えられる。