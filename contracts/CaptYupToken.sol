// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
contract CaptYupToken is Ownable, Pausable, ERC1155Burnable, ERC1155Supply, ERC1155URIStorage {

    constructor() ERC1155("https://cdn.captyup.io/{id}.json") {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
    function setURI(uint256 tokenId, string memory tokenURI) public {
        _setURI(tokenId,tokenURI);
    }
    function uri(uint256 tokenId) public view virtual override(ERC1155,ERC1155URIStorage) returns (string memory) {
        return super.uri(tokenId);
    }
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
    {
        _mintBatch(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        whenNotPaused
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
