pragma solidity ^0.4.11;
contract Splitter {
    
  struct Shareholder{
      //address account;
      uint percentageAllocation;
      uint totalPaid;
  }
  uint public _maxNumberOfShareholders=5;
  uint public _maxAllocation=80; // only 80% can be distributed
  uint public _currentAllocation=0; 
  uint public _shareholderCount=0;
  
  mapping(address=>Shareholder) public shareholders;
  
  
   // Shareholder[] shareholders;
  
  function Splitter(uint numberOfShareholders)
    {
      if (numberOfShareholders<=0) revert();
      _maxNumberOfShareholders =numberOfShareholders;
  }
  
  function AddShareholder(uint percentageAllocation)
 // payable
   public
  CheckShareholderCount
  returns(bool)
 
  {
      
     if (percentageAllocation<0 || percentageAllocation>80) revert();
      
      
     
      if (shareholders[msg.sender].percentageAllocation != 0) revert();
      
      shareholders[msg.sender].percentageAllocation=percentageAllocation;
      
      _shareholderCount++;
      
      return true;
  }
  
  modifier CheckShareholderCount(){
      
      if (_shareholderCount==_maxNumberOfShareholders) revert();
       _;
      
  }
 
  
   
  
}