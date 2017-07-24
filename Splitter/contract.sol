pragma solidity ^0.4.4;
contract Splitter {

// contract owner
//uint128 p=0.8;
  address _owner;
  struct Shareholder{
    
     uint percentage;
      uint totalPaid;
  }
  
  uint public _maxNumberOfShareholders=5;
  uint public _maxAllocation=80; // only 80% of the total funds will be distributed amongst shareholders
  event logSplitAmout(address act,uint balance,uint percentage,uint amt);
  
  mapping(address=>Shareholder) public shareholders;
  address[] public shareholderAccounts;
  
  function Splitter(uint noOfShareholders)
  payable
    {
      // when contract will be deployed, shareholders will be caped
      if (noOfShareholders<=0) revert();
      _maxNumberOfShareholders =noOfShareholders;
      _owner=msg.sender;
      
  }
  
  function AddShareholder(address account,uint percentage)
   public
   IsOwner // only owner of the contract can add the shareholders
  CheckShareholderCount
  CheckShareholderAllocation(percentage)
  returns(bool)
 
  {
      
     if (percentage<0 || percentage>80) revert();
      
      if (shareholders[account].percentage != 0) revert();
      
      shareholders[account].percentage=percentage;
     
      shareholderAccounts.push(account);
      //_shareholderCount++;
      
      return true;
  }
  
  modifier CheckShareholderAllocation(uint percentage){
      uint temp = GetTotalAllocation();
      // check if max % allocation has reached
     if (temp == _maxAllocation) revert();
      // total allocation shouldnt be more than intially agreed, in this instance we are only splitting 80% 
      // of the fund value
      if (temp + percentage >_maxAllocation ) revert();
      _;
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
      Split();
      return true;
      
  }
  
  modifier CheckShareholderCount(){
      
      if (shareholderAccounts.length==_maxNumberOfShareholders) revert();
       _;
      
  }
   function GetTotalAllocation()
   public
   constant
   returns (uint)
   {
      uint temp;
      for(uint i =0;i<shareholderAccounts.length;i++)
      {
          temp += shareholders[shareholderAccounts[i]].percentage;
      }
     
     return temp;
  }
 function GetShareholderCount()
 constant
 public
 returns (uint)
 {
     return shareholderAccounts.length;
 }
 
  function Balance()
  constant
  returns(uint)
  {
      
      return this.balance;
  }
  
  function Split()
  returns (uint){
       address act;
       uint amount;
      
      for(uint i =0;i<shareholderAccounts.length;i++)
      {
          act=shareholderAccounts[i];
         // (address act,uint balance,uint percentage,uint amt);
          amount =  (this.balance * shareholders[act].percentage)/100;
          logSplitAmout(act,this.balance,shareholders[act].percentage,amount);
     
        
          act.transfer(amount);
          shareholders[act].totalPaid +=amount;
          
      }
      return amount;
  }
 
}
