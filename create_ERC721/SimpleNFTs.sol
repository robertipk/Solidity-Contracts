//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SimpleNFTs is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("SimpleNFTs", "SimpleNFT") {}

    function mintNFT(address recipient, string memory tokenURI) public returns (uint256)
   {
       // Increment token id count to create new token id
       _tokenIds.increment();
       uint256 newItemId = _tokenIds.current();

       // create the NFT
       _mint(recipient, newItemId);
       // associate tokenURI with the token
       _setTokenURI(newItemId, tokenURI);

       return newItemId;
   }
}

