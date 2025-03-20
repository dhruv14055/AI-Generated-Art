// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicMetadataNFT {

    uint256 private _tokenIdCounter;
    mapping(uint256 => address) public owners;
    mapping(uint256 => string) private _tokenMetadata;

    // Event to be emitted when a new NFT is minted
    event Minted(address owner, uint256 tokenId);

    // Mint a new NFT
    function mint() public {
        _tokenIdCounter++;
        uint256 tokenId = _tokenIdCounter;

        // Assign ownership of the token
        owners[tokenId] = msg.sender;

        // Dynamic metadata could be generated and assigned here
        // For simplicity, we assign a placeholder metadata string
        _tokenMetadata[tokenId] = string(abi.encodePacked("metadata for token ", uint2str(tokenId)));

        emit Minted(msg.sender, tokenId);
    }

    // Get the owner of a specific token
    function ownerOf(uint256 tokenId) public view returns (address) {
        return owners[tokenId];
    }

    // Get the dynamic metadata for a token
    function tokenMetadata(uint256 tokenId) public view returns (string memory) {
        return _tokenMetadata[tokenId];
    }

    // Helper function to convert uint to string (used for dynamic metadata)
    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) {
            return "0";
        }
        uint256 temp = _i;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory bstr = new bytes(digits);
        uint256 index = digits - 1;
        while (_i != 0) {
            bstr[index--] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        str = string(bstr);
    }
}
