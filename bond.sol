pragma solidity ^0.4.11;/* a smart contract to trade bonds */
contract bond{
    uint256 bond_supply = 10;
    mapping (address=> uint256) bonds;
    uint256 initial_supply= 10000;
    mapping (address=> uint256) balances;
    
    function bondinitial() public{
        bonds[msg.sender]=bond_supply;
    } 
    function balanceof(address _buyer) public constant returns (uint256){
        return balances[_buyer];
    }
    /*set a time stamp*/
    function time(uint bond_start, uint daysafter) public{
        if(now>= bond_start+ daysafter*1 days){
            selfdestruct(msg.sender);
        }
    }
    /* we assume bond has a par value of 1000 tokens */
    function transfer(address _buyer, uint256 _amount) public {
        require(bonds[msg.sender]>_amount); 
        require(balanceof(_buyer)>_amount*1000);
        bonds[msg.sender]-= _amount;
        bonds[_buyer]+= _amount;
        balances[msg.sender]+= _amount*1000;
        balances[_buyer]-=_amount*1000;    
    }
