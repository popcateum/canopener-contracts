// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../interfaces/ICanopener.sol";
import "../openzeppelin/contracts/utils/Context.sol";
import "../openzeppelin/contracts/utils/Counters.sol";

contract MintV1 is Context {
	using Counters for Counters.Counter;

	bool public isMint;
	address public devAddress;
	ICanopener public nft;
	Counters.Counter internal whiteListTracker;

	mapping(address => bool) public whiteList;

	constructor(address _nft, address _dev, bool _isMint) {
		nft = ICanopener(_nft);
		devAddress = _dev;
		isMint = _isMint;
	}

	modifier onlyDev() {
		require(devAddress == _msgSender(), "only dev: caller is not the dev");
		_;
	}

	modifier whiteListRole() {
		require(whiteList[_msgSender()], "This address is not on the whitelist");
		_;
	}

	modifier mintRole() {
		require(isMint, "Mint is not started");
		_;
	}

	function mint() public whiteListRole mintRole {
		nft.safeMint(_msgSender());
	}

	function setWhiteList(address[] memory wl) public onlyDev {
		for (uint256 i = 0; i < wl.length; i++) {
			whiteList[wl[i]] = true;
			whiteListTracker.increment();
		}
	}

	function setIsMint() public onlyDev {
		isMint = !isMint;
	}

	function getWhiteListLength() public view returns (uint256) {
		return whiteListTracker.current();
	}
}
