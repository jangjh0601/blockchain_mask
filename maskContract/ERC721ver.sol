pragma solidity ^0.6.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

/**
 * @title maskSaver main contract
 * @dev maskSaver contract that make transaction and mint
 *  from ERC721X contracts.
 */
contract maskSaver is ERC721 {

    struct Mask {
        string  manufacturerName;
        address manufacturerAddr;
        uint256 date;
    }
    
    Mask[] public Masks; // 첫 아이템의 인덱스는 0입니다
    uint256[] public maskIDIntList;
    address public owner;
    
    constructor() public ERC721("Mask", "MSK") {
            owner = msg.sender;
    }
    
    event Making(uint256 tokenId);
    
    /**
     * @dev mask making start with tokenId for order // FT
     * @param _name string to write mask manufacturerName
     * @param _account The address to batchTransfer objects to.
     */
    function _maskMaking(string memory _name, address _account) public {
        //require(msg.sender == owner);
        Masks.push(Mask(_name, _account, now));
        uint256 tokenId = Masks.length - 1; // 유일한 마스크  ID
        _mint(_account, tokenId); // FT 새 마스크를 생산
        maskIDIntList.push(tokenId);
        emit Making(tokenId);
    }
     
    // deal function
    function dealMasks(address _from, address _to, uint256 _tokenId) public {
        //require(ownerOf(_tokenId) == _from);
        transferFrom(_from, _to, _tokenId);
    }
    
    //논란의 여지가 있음. 소각은 나중에 생각하기로
    function burnToken(uint256 _tokenId) public {
        // if 60days later after sold mask, burn token
        require(checkDate60(_tokenId));
        _burn(_tokenId);
    }
    
    // check date thst based on law ---> true ->ok  / false ->not ok
    function checkDate(uint256 maskId) public view returns (bool) {
        return (Masks[maskId].date + 5 days > block.timestamp);
    }
    
    // for burn token
    function checkDate60(uint256 maskId) public view returns (bool) {
        return (Masks[maskId].date + 60 days > block.timestamp);
    }
    
    // check mask list whick token is inside
    function maskListReturn(uint256 _number) public view returns (uint256) {
        return maskIDIntList[_number];
    }
} 
