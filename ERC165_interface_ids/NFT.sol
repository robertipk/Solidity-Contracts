//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// NFT smart contract that implements ERC165.
// Exposes methods for returning the interface ids for
// interfaces such as ERC165, ERC721, ERC721 Enumerable,
// ERC721 Metadata.
contract NFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("NonFungibleTokens", "NFT") {
      // mint a few NFTs to myself during contract creation
      for (uint i = 0; i < 10; i++) {
        mintNFT(msg.sender, "");
      }
    }

    // get interfaceId for IERC165 (Standard Interface Detection)
    function getERC165InterfaceId() pure public returns (bytes4){
        return type(IERC165).interfaceId;
    }

    // get interfaceId for IERC721 (Non-fungible tokens)
    function getERC721InterfaceId() pure public returns (bytes4){
        return type(IERC721).interfaceId;
    }

    // get interfaceId for IERC721 Enumerable
    function getERC721EnumerableInterfaceId() pure public returns (bytes4){
        return type(IERC721Enumerable).interfaceId;
    }

    // get interfaceId for onERC721Received(address,uint256,bytes)
    function getOnERC721ReceivedSelector() pure public returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }

    // Call bytes4(keccak256) on a string.
    // You can pass in a method (and its argument types) to see what hash will be generated
    function getInterfaceId(string memory _function_signature) pure public returns (bytes4){
        return bytes4(keccak256(abi.encodePacked(_function_signature))); 
    }

    function mintNFT(address recipient, string memory tokenURI) public
       returns (uint256)
   {
       _tokenIds.increment();

       uint256 newItemId = _tokenIds.current();
       _mint(recipient, newItemId);
       _setTokenURI(newItemId, tokenURI);

       return newItemId;
   }
}

