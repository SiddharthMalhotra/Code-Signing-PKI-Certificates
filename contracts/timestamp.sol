pragma solidity ^0.4.18;
contract timestampServer  {
    
    address dc;
    uint _val; 
    
    uint timestamp;
    
    function start(){
        timestamp = now;
    } 
    
    function ts() view public returns (uint) {
        return timestamp;
    }

    function ExistingWithoutABI(address _t) public {
        dc = _t;
    }
    
    function InterCA_timestamp() public returns(bool success){
        require(dc.call(bytes4(keccak256("timestamp(uint256)")),timestamp));
        return true;
    }
    
}