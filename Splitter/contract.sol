contract Splitter {

// contract owner
address _alice;
address _bob;
address _carol;

  function Splitter(address bob,address carol)
  payable
    {
     
      _alice=0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
      _bob=bob;
      _carol=carol;
           
  }
  
  function Donate()
  payable
  returns(bool)
  {
      if (msg.sender==_alice){
          
          _bob.send(msg.value/2);
          _carol.send(msg.value/2);
      }
      return true;
      
  }
  
  function Balance()
  constant
  returns(uint)
  {
      
      return this.balance;
  }
  
 

}
