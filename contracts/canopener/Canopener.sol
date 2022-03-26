// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../openzeppelin/contracts/access/Ownable.sol";
import "../openzeppelin/contracts/utils/Counters.sol";

contract Canopener is ERC721, ERC721Enumerable, Ownable {
	using Counters for Counters.Counter;
	event SetBlacklist(address indexed user, bool status);

	string private _baseTokenURI;
	uint256 public maxSupply;
	address public mintContract;

	mapping(address => bool) public blacklist;

	Counters.Counter private _tokenIdCounter;

	constructor(string memory _uri, uint256 _amount) ERC721("Can Opener", "CO") {
		setBaseURI(_uri);
		setMaxSupply(_amount);
	}

	modifier onlyMinter() {
		require(_msgSender() == mintContract);
		_;
	}

	function safeMint(address to) public onlyMinter {
		require(totalSupply() < maxSupply, "Mint end");
		require(balanceOf(to) == 0, "Only one NFT can be owned");
		uint256 tokenId = _tokenIdCounter.current();
		_tokenIdCounter.increment();
		_safeMint(to, tokenId);
	}

	function transferFrom(
		address from,
		address to,
		uint256 tokenId
	) public virtual override {
		require(false, "This NFT cannot be transfer");
		_transfer(from, to, tokenId);
	}

	function safeTransferFrom(
		address from,
		address to,
		uint256 tokenId,
		bytes memory _data
	) public virtual override {
		require(false, "This NFT cannot be transfer");
		_safeTransfer(from, to, tokenId, _data);
	}

	function setBaseURI(string memory baseURI) public onlyOwner {
		_baseTokenURI = baseURI;
	}

	function setMintContract(address ca) public onlyOwner {
		mintContract = ca;
	}

	function setMaxSupply(uint256 amount) public onlyOwner {
		maxSupply = amount;
	}

	function setBlacklist(address user, bool status) external onlyOwner {
		blacklist[user] = status;
		emit SetBlacklist(user, status);
	}

	function _baseURI() internal view override returns (string memory) {
		return _baseTokenURI;
	}

	function _beforeTokenTransfer(
		address from,
		address to,
		uint256 tokenId
	) internal override(ERC721, ERC721Enumerable) {
		super._beforeTokenTransfer(from, to, tokenId);
	}

	function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
		return super.supportsInterface(interfaceId);
	}
}
