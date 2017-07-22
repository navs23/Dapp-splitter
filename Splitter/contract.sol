pragma solidity ^0.4.4;
contract FundSplitter {
    
  struct Shareholder{
      address account;
      uint percentage;
      
  }
  uint public _maxNumberOfShareholders=5;
  
  uint public _maxAllocation=80; // only 80% can be distributed
   /*
  function FundSplitter(uint numberOfShareholders)
  
  {
      
      _maxNumberOfShareholders =numberOfShareholders;
  }
  */
  
  Shareholder[] shareholders;
  
  function AddShareholder(address account,uint percentage)
  payable
  CheckShareholderCount
  CheckTotalPercentage(percentage)
  public
  {
      if (percentage<0 || percentage>80) revert();
      // add share holder
      shareholders.push(Shareholder({
          account:account,percentage:percentage
      }));
      
  }
  
  modifier CheckShareholderCount()
  {
      
      if (shareholders.length ==_maxNumberOfShareholders) revert();
      _;
      
  }
  
  // get total fund split
  function GetTotalAllocation()
  constant
  public
  returns(uint)
  {
      uint temp=0;
       for( uint i =0;i < shareholders.length;i++)
        temp +=shareholders[i].percentage;
      return temp;
  }
  
  // get share holder count
  
  function GetShareholderCount()
  constant
  returns(uint)
  {
      
      return shareholders.length;
  }
  
  // total percentage should be less than 80 as 20% is reserved in the contract
    modifier CheckTotalPercentage(uint percentage)
  {
      uint temp=GetTotalAllocation();
     
        
      if ((temp +percentage) >_maxAllocation) revert();
      _;
      
  }
  
  function FundsAvailable()
  constant
  returns(uint)
  {
      
      return this.balance;
  }
  
  
  
}