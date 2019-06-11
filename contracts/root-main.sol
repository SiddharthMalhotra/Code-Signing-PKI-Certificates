pragma solidity ^0.4.6;


import "./Dictionary.sol";
import "./owned.sol";
// Compile and deploy E by itself. 

contract E is owned {

    uint public x;
    string public AuthorityName;
    bytes public value;
    address public self_address= this;
    
    using Dictionary for Dictionary.Data;
    Dictionary.Data private dic;
    
    event LogUpdate(uint newXValue);

    function set(uint _x) public returns(bool success) {
        x = _x;
        //LogUpdate(x);
        return true;
    }
    
    
    function setAuthorityName (string _AuthorityName) onlyOwner public returns(bool success){
        AuthorityName = _AuthorityName;
        //LogUpdate(x);
        return true;
    }
    
    
    function myAddress() public returns(address) {
      self_address = this;
      return self_address;
      
   }
   
   
   address[] public MemberAddresses;
   
   function intermidiateCA(address _address) public returns(bool success){
       MemberAddresses.push(_address);
   }
    
}











// // These go in one source file.
// // The compiler can "see" the E Interface as it compiles F.

contract EInterface {
    uint public x;
    bytes public value;
    address public self_address;
    string public AuthorityName;
    address[] public MemberAddresses;
    
    
    
    function set(uint _x) returns(bool success) {} // undefined function is part of the "Interface".
    function Foo() public view returns (bytes) {}
    function setAuthorityName (string _AuthorityName) public returns(bool success){}
    function intermidiateCA(address _address) public returns(bool success){}
    
    
    
}






// contract F {

//     uint public x;
//     address addressE;

//     // E is already deployed.
//     // Conveniently pass E's address to F

//     function F(address EAddress) {
//         addressE = EAddress;
//     }

//     function setE(uint num) public returns(bool) {
//         // valid ... 
//         // return addressE.call(bytes4(sha3('set(uint256)')), num);
//         E e = E(addressE); // "EInterface" is understood from interface code above.
//         return e.set(num);
//     }

//     function getE() public constant returns(uint) {
//         EInterface e = EInterface(addressE);
//         return e.x();  
//     }
    
    
    
//     function getAuthorityName() public constant returns(string) {
//         EInterface e = EInterface(addressE);
//         return e.AuthorityName();  
//     }
    
//      function getAuthorityAddress() public constant returns(address) {
//         EInterface e = EInterface(addressE);
//         return e.self_address();  
//     }
    
//     function Foo() public constant returns(bytes){
//         EInterface e = EInterface(addressE);
//         return e.value();
//     }
    
//     function setinter(uint _x) public returns(bool success) {
//         x = _x;
//         //LogUpdate(x);
//         return true;
//     }

// }