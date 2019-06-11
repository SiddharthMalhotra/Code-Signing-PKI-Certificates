pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2;

import "./owned.sol";
import "./Root-Main.sol";
import "./Dictionary.sol";




contract F{

    uint public x;
    address addressE;
    uint public timeStamp;
    bytes public value;
    
    
    // struct users
    // {
    //      string name;
    //      uint level;
    //      uint score;
    // }

    
    
    string[] csr;
    
    using Dictionary for Dictionary.Data;
    Dictionary.Data public dic;
    
    // using Dictionary for dictionary2.Data;
    // dictionary2.Data public dic2; 

    // E is already deployed.
    // Conveniently pass E's address to F

    function F(address EAddress) {
        addressE = EAddress;
        E e = E(addressE); 
        e.intermidiateCA(intermidate_address);
    }

    function setE(uint num) public returns(bool) {
        // valid ... 
        // return addressE.call(bytes4(sha3('set(uint256)')), num);
        E e = E(addressE); // "EInterface" is understood from interface code above.
        return e.set(num);
    }

    // E is already deployed.
    // Conveniently pass E's address to F
    function constructor(address EAddress) {
        addressE = EAddress;
        E e = E(addressE); 
        e.intermidiateCA(intermidate_address);
    }
    
    
    // function setE(uint num) public returns(bool) {
    //     // valid ... 
    //     // return addressE.call(bytes4(sha3('set(uint256)')), num);
    //     E e = E(addressE); // "EInterface" is understood from interface code above.
    //     return e.set(num);
    // }
    
    
    // function getE() public constant returns(uint) {
    //     EInterface e = EInterface(addressE);
    //     return e.x();  
    // }
    
    
    
    // function getAuthorityName() public constant returns(string) {
    //     EInterface e = EInterface(addressE);
    //     return e.AuthorityName();  
    // }
    
    //  function getAuthorityAddress() public constant returns(address) {
    //     EInterface e = EInterface(addressE);
    //     return e.self_address();  
    // }
    
    // function Foo() public constant returns(bytes){}

    function getE() public constant returns(uint) {
        EInterface e = EInterface(addressE);
        return e.x();  
    }
    
    
    
    function getAuthorityName() public constant returns(string) {
        EInterface e = EInterface(addressE);
        return e.AuthorityName();  
    }
    
     function getAuthorityAddress() public constant returns(address) {
        EInterface e = EInterface(addressE);
        return e.self_address();  
    }
    
    function Foo() public constant returns(bytes){
        EInterface e = EInterface(addressE);
        return e.value();
    }
    
    function setinter(uint _x) public returns(bool success) {
        x = _x;
        //LogUpdate(x);
        return true;
    }
    
    
    function timestamp(uint _a) public returns (uint) {
        timeStamp = _a;
        return timeStamp;
    }
    
    
    function Datadictionary() public returns (bytes) {

        
        dic.set(1, "fizz");
        dic.set(2, "foo");
        dic.set(123, "bar");
        dic.set(1, "new value");
        // get an item
        value = dic.get(2); // => '0x666f6f' (byte hex of 'foo')
        // get all keys
        dic.keys(); // => [1, 2, 123]
        
        return value; 
    }
    
    
      
    
    function Datadictionary() public returns (bytes) {

        
        dic.set(1, "fizz");
        dic.set(2, "foo");
        dic.set(123, "bar");
        dic.set(1, "new value");
        // get an item
        value = dic.get(2); // => '0x666f6f' (byte hex of 'foo')
        // get all keys
        dic.keys(); // => [1, 2, 123]
        
        return value; 
    }
    
    
    
    function Test(string _a) constant returns (string[]) {
       csr.push(_a); 
       return csr;
    }
    
    address public intermidate_address= this;
    
    //     timeStamp = _a;
    //     return timeStamp;
    // }
    
    
    // function Datadictionary() public returns (bytes) {
        
    //     dic2.set(1, "fizz");
    //     dic2.set(2, "foo");
    //     dic2.set(123, "bar");
    //     dic2.set(1, "new value");
    //     // get an item
    //     value = dic.get(2); // => '0x666f6f' (byte hex of 'foo')
    //     // get all keys
    //     dic2.keys(); // => [1, 2, 123]
        
    //     return value; 
    // }
    
    
    // function Test(string _a) constant returns (string[]) {
    //   csr.push(_a); 
    //   return csr;
    // }
    
    // address public intermidate_address= this;
    
    // function intermidiateCA() public returns(bool) {
    //     E e = E(addressE); 
    //     return e.intermidiateCA(intermidate_address);
    // }
    
}

    // function intermidiateCA() public returns(bool) {
    //     E e = E(addressE); 
    //     return e.intermidiateCA(intermidate_address);
    // }
    

// }






contract FInterface {
    uint public x;
    bytes public value;
    address public self_address;
    string public AuthorityName;
    
    
    
    function set(uint _x) returns(bool success) {} // undefined function is part of the "Interface".
    function Foo() public view returns (bytes) {}
    function setAuthorityName (string _AuthorityName) public returns(bool success){}
    
    function Test(string _a) constant returns (string[]) {}
}