        var eth = new Eth(TestRPC.provider());
        var el = function(id){ return document.querySelector(id); };

        var _maxNumberOfShareholders=3;
        var _contractBytecode = helper.getBytecode();
        var _contractABI = helper.getContractAbi();
        var _contract ;
        var _contractInstance;
        var _accounts=[];
        var _shareholderAccounts=[];
      /*
      // uncomment to enable MetaMask support:
      if (typeof window.web3 !== 'undefined' && typeof window.web3.currentProvider !== 'undefined') {
        eth.setProvider(window.web3.currentProvider);
      } else {
        eth.setProvider(provider); // set to TestRPC if not available
      }
      */
     
      eth.accounts().then(function(accounts) {
          var element={};
             accounts.forEach(function(account){
       
              eth.getBalance(account, function(balanceError, balance){
                      
                    element.account=account;
                     // var balancestr = Eth.fromWei(balance, 'ether');
                      element.balance = Eth.fromWei(balance, 'ether');;
                    
                      el('#accounts').innerHTML += '<option value="' + element.account + '">' + element.account +'['+ element.balance +']';
                        //alert(JSON.stringify(element));
                  
                        _accounts.push(element);

                  
              });
                   

                    
        });

       
        _contract = eth.contract(_contractABI, _contractBytecode, { from: accounts[0], gas: 800000 });

            DeployContract(_maxNumberOfShareholders);
        
      });

function DeployContract(maxNumberOfShareholders){

_contract.new(maxNumberOfShareholders).then(function(txHash){
         // poll for response
          var checkTransaction = setInterval(function(){

            eth.getTransactionReceipt(txHash).then(function(receipt){
              if (receipt) {
                  
                clearInterval(checkTransaction);
                _contractInstance = _contract.at(receipt.contractAddress);

                el('#response').innerHTML = 'Contract deployed to address: ' + String(receipt.contractAddress);
            
                $('#toAccount').attr('value',String(receipt.contractAddress));
              $('#toAccount').attr('readOnly');
          _contractInstance._maxNumberOfShareholders().then(function(valueStored){
                    el('#maxShareholder').innerHTML =  valueStored[0].toString(10);
                  });
 _contractInstance._maxAllocation().then(function(valueStored){
                    el('#maxAllocation').innerHTML =  valueStored[0].toString(10) + '%';
                  });
               //GetShareholderCount
                _contractInstance._shareholderCount().then(function(valueStored){
                    el('#shareholder').innerHTML =  valueStored[0].toString(10);
                  });
                  
              }
            });
          }, 400);
        })
        .catch(function(error){

          el('#response').innerHTML = 'There was an error: ' + String(error);
        });
}

function PopulateDonarAccountList(){


       // alert(JSON.stringify(_shareholderAccounts));

        $('#fromAccount').empty();
        var bfound=false;
      
        var temp={};

        $("#accounts > option").each(function() {

            bfound=false;

                temp=this;
              for(var k =0;k<_shareholderAccounts.length;k++)
              {
                if(temp.value == _shareholderAccounts[k]){
                bfound=true;
                break;
                }

                
              }
              if (!bfound)
                $('#fromAccount').append('<option value="' + temp.value + '">'+temp.text );
        });

       
}
