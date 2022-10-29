# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```

# API
## PropheteetToken.sol
### buyNFT
```solidity
    function buyNFT() public returns(bool) {
        address sender = _msgSender();
        require(balanceOf(sender, 0) >= NFTPrice, "No available balance");
        _burn(sender, 0, NFTPrice);
        _mint(sender, 1, 1, "0x");
        return true;
    }
```
正解トークンでNFTを買います。

## Prophetweet.sol
### trial
### claim