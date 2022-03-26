// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface ICanopener {
	function safeMint(address to) external;

	function balanceOf(address owner) external view returns (uint256 balance);
}
