// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

interface INounsToken {
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract N900UNS is ERC721Enumerable, Ownable {
   uint256 public mintFee = 0.00899 ether;
   uint256 public MAX_SUPPLY = 900;
   INounsToken private nounsToken;

   constructor(address initialOwner)
      ERC721("N900UNS", "N900UNS")
      Ownable(initialOwner) 
   {
      nounsToken = INounsToken(0x99265CE0983aab76F5a3789663FDD887dE66638A);
      safeMint(initialOwner, 0);
      // 0x99265CE0983aab76F5a3789663FDD887dE66638A goerli
      // 0x9C8fF314C9Bc7F6e59A9d9225Fb22946427eDC03 mainnet
   }

   function tokenURI(uint256 tokenId) override public view returns (string memory){
      string  memory uri = nounsToken.tokenURI(tokenId);
      return uri;
   }

   function safeMint(address to, uint256 tokenId) public onlyOwner {
      _safeMint(to, tokenId);
   }

   function setMint(uint256 newFee) public onlyOwner {
      mintFee = newFee;
   }

   function mintNext() public payable {
      require(msg.value == mintFee, "Incorrect fee paid");
      uint256 tokenId = totalSupply();
      require(tokenId < MAX_SUPPLY, "Supply limit reached.");
      safeMint(msg.sender, tokenId);
   }

   function withdraw() public onlyOwner {
      uint256 balance = address(this).balance;
      payable(owner()).transfer(balance);
   }
}
