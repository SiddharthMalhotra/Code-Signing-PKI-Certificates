pragma solidity ^0.4.18;
pragma experimental ABIEncoderV2;

import "./Root-Inter.sol";

contract CSR{
    
    
  struct UserStruct {
    bytes32 CommonName;
    uint requester_identifier;
    bytes32 binaryhash;
  }
  
    
  mapping(address => UserStruct) private userStructs;
  address[] private userbinaryhash;

  function insertUser(address userAddress, bytes32 CommonName, bytes32 requester_identifier) public returns(uint binaryhash)
  {
    userStructs[userAddress].CommonName = CommonName;
    userStructs[userAddress].requester_identifier   = requester_identifier;
    userStructs[userAddress].binaryhash     = userbinaryhash.push(userAddress)-1;

    return userbinaryhash.length-1;
  }
  
    function getUser(address userAddress) public constant returns(bytes32 CommonName, bytes32 requester_identifier, uint binaryhash)
  {
    return(
      userStructs[userAddress].CommonName, 
      userStructs[userAddress].requester_identifier, 
      userStructs[userAddress].binaryhash);
  } 
}