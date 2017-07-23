pragma solidity ^0.4.4;
contract Splitter {

// contract owner
address _owner;
  struct Shareholder{
    
     uint percentageAllocation;
      uint totalPaid;
  }
  uint public _maxNumberOfShareholders=5;
  uint public _maxAllocation=80; // only 80% can be distributed
  uint public _currentAllocation=0; 
  uint public _shareholderCount=0;
  
  mapping(address=>Shareholder) public shareholders;
  address[] public shareholderAccounts;
  
  function Splitter(uint noOfShareholders)
  payable
    {
      if (noOfShareholders<=0) revert();
      _maxNumberOfShareholders =noOfShareholders;
      _owner=msg.sender;
      
  }
  
  function AddShareholder(address account,uint percentageAllocation)
   public
   IsOwner
  CheckShareholderCount
  returns(bool)
 
  {
      
     if (percentageAllocation<0 || percentageAllocation>80) revert();
      
      if (shareholders[account].percentageAllocation != 0) revert();
      
      shareholders[account].percentageAllocation=percentageAllocation;
     
      shareholderAccounts.push(account);
      _shareholderCount++;
      
      return true;
  }
  
  
  modifier IsOwner()
  {
      if (_owner != msg.sender) revert();
      _;
  }
  function Donate()
  payable
  returns(bool)
  {
      
      return true;
      
  }
  
  modifier CheckShareholderCount(){
      
      if (_shareholderCount==_maxNumberOfShareholders) revert();
       _;
      
  }
 
 
  function Balance()
  constant
  returns(uint)
  {
      
      return this.balance;
  }
  

}