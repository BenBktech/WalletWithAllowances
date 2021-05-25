pragma solidity ^0.8.1;

import './Allowances.sol';

contract Wallet is Allowances {
   
    //Events
    event moneyWithdrawed(address indexed _byWhom, address indexed _fromOwner, uint _oldAmount, uint _newAmount);
    
    //Check if the user is allowed to withdraw money
    modifier allowedToWithdraw(address _owner, address _beneficiary, uint _amount) {
        require(OwnersAndBeneficiaries[_owner][_beneficiary].allowance - _amount > 0, "You can't withdraw as much money.");
        require(_beneficiary == msg.sender || msg.sender == _owner, "You cannot withdraw someone else's money.");
        _;
    }
    
    //Withdraw money when you are a beneficiary
    function withdrawMoneyToBeneficiary(address _owner, address payable _beneficiary, uint _amount) public allowedToWithdraw(_owner, _beneficiary, _amount) {
        emit moneyWithdrawed(_beneficiary, _owner, OwnersAndBeneficiaries[_owner][_beneficiary].allowance, OwnersAndBeneficiaries[_owner][_beneficiary].allowance - _amount);
        OwnersAndBeneficiaries[_owner][_beneficiary].allowance = OwnersAndBeneficiaries[_owner][_beneficiary].allowance - _amount;
        _beneficiary.transfer(_amount);
    }
    
    //Withdraw money when you are an owner 
    function withdrawMoneyFromOwner(address payable _owner, address _beneficiary, uint _amount) public allowedToWithdraw(_owner, _beneficiary, _amount) {
        emit moneyWithdrawed(_beneficiary, msg.sender, OwnersAndBeneficiaries[msg.sender][_beneficiary].allowance, OwnersAndBeneficiaries[msg.sender][_beneficiary].allowance - _amount);
        OwnersAndBeneficiaries[msg.sender][_beneficiary].allowance = OwnersAndBeneficiaries[msg.sender][_beneficiary].allowance - _amount;
        _owner.transfer(_amount);
    } 
}
