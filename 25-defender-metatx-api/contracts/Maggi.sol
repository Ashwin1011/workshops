// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/metatx/MinimalForwarder.sol";

/// @title A simple, permissioned airdrop claim contract.
/// @author Ashwin S. Parihar
/// @notice You can use this contract for distributing random NFTs.
contract ClaimMaggi is Ownable, ERC2771Context {
    using Address for address;
    uint256[] nftsToDistribute;
    // mapping(address => bool) public claimers;
    address[] public Admins;
    // mapping(address => bool) public AdminByAddress;

    bool public paused;

    IERC1155 private orareToken1155;

    constructor(
        IERC1155 _orareToken1155,
        MinimalForwarder forwarder
    ) ERC2771Context(address(forwarder)) {
        orareToken1155 = IERC1155(_orareToken1155);
    }

    function _msgSender()
        internal
        view
        override(Context, ERC2771Context)
        returns (address sender)
    {
        sender = ERC2771Context._msgSender();
    }

    function _msgData()
        internal
        view
        override(Context, ERC2771Context)
        returns (bytes calldata)
    {
        return ERC2771Context._msgData();
    }

    event NFTClaimed(address user, uint256[] id, uint256[] amount);

    event SetAdmins(address[] Admins);

    /**
     * @dev set NFT tokens ids for distribution here.
     */
    function setNftTokensArray(uint256[] memory _arr) external onlyOwner {
        nftsToDistribute = _arr;
    }

    function pauseContract() public onlyOwner returns (bool) {
        require(paused == false, "Already paused");
        paused = true;
        return true;
    }

    function unpauseContract() public onlyOwner returns (bool) {
        require(paused == true, "Already unpaused");
        paused = false;
        return true;
    }

    /**
     * @dev Function to distribute random NFTs
     * @notice Before calling this function make sure that admins and NFTs
     * are set by the owner and the contract is not paused.
     */
    function sendNfts(
        address _user,
        uint256[] memory ids,
        uint256[] memory qtys
    ) public returns (bool) {
        require(!_user.isContract(), "Maggi: User should be an address");

        orareToken1155.safeBatchTransferFrom(
            address(this),
            _user,
            ids,
            qtys,
            "0x"
        );

        emit NFTClaimed(_user, ids, qtys);
        return true;
    }

    // modifier onlyAdmin() {
    //     require(AdminByAddress[msg.sender] == true, "Caller not an Admin");
    //     _;
    // }

    /**
     * @dev Function to recover NFTs locked in the contract.
     * @notice Batch transfer is enabled.
     */
    function recoverERC1155(
        uint256[] memory tokenId,
        uint256[] memory amount
    ) external onlyOwner {
        orareToken1155.safeBatchTransferFrom(
            address(this),
            msg.sender,
            tokenId,
            amount,
            "0x"
        );
    }

    // /**
    //  * @dev Set admins (only owner)
    //  * @notice To set new Admins, send the old ones too in the parameter.
    //  */
    // function setAdmins(address[] memory _Admins) public onlyOwner {
    //     _setAdmins(_Admins);
    // }

    // function _setAdmins(address[] memory _Admins) internal {
    //     for (uint256 i = 0; i < Admins.length; i++) {
    //         AdminByAddress[Admins[i]] = false;
    //     }

    //     for (uint256 j = 0; j < _Admins.length; j++) {
    //         AdminByAddress[_Admins[j]] = true;
    //     }
    //     Admins = _Admins;
    //     emit SetAdmins(_Admins);
    // }

    // function getAdmins() public view returns (address[] memory) {
    //     return Admins;
    // }

    function onERC1155Received(
        address _operator,
        address _from,
        uint256 _id,
        uint256 _value,
        bytes calldata _data
    ) external pure returns (bytes4) {
        return 0xf23a6e61;
    }

    function onERC1155BatchReceived(
        address _operator,
        address _from,
        uint256[] calldata _ids,
        uint256[] calldata _values,
        bytes calldata _data
    ) external pure returns (bytes4) {
        return 0xbc197c81;
    }
}
