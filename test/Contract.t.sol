// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ERC721.sol";

contract ContractTest is Test {

    ERC721 erc721;

    address alice = address(0x1);
    address bob = address(0x2);

    function testMintToken() public {
        erc721 = new ERC721();
        erc721.mint(alice, 0);
        address ercOwner = erc721.ownerOf(0);
        assertEq(alice, ercOwner);
    }

    function testTransfer() public {
        erc721 = new ERC721();
        erc721.mint(alice, 0);

        vm.startPrank(alice);

        erc721.safeTransferFrom(alice, bob, 0);
        address ercOwner = erc721.ownerOf(0);
        assertEq(ercOwner, bob);
    }

    function testGetBalance() public {
        erc721 = new ERC721();
        erc721.mint(alice, 0);
        erc721.mint(alice, 1);
        erc721.mint(alice, 2);
        erc721.mint(alice, 3);
        uint ercOwnerBalance = erc721.balanceOf(alice);
        assertEq(ercOwnerBalance, 4);
    }

    function testOnlyOwnerBurn() public {
        erc721 = new ERC721();
        erc721.mint(alice, 0);
        vm.startPrank(bob);
        vm.expectRevert("not owner of token");
        erc721.burn(0);
    } 
}
