pragma solidity 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowances {
    
    mapping(address => mapping(address => Beneficiaries)) OwnersAndBeneficiaries;
    struct Beneficiaries {
        uint numberOfAllowances;
        uint allowance;
    }
    
    //Events
    event AllowanceChanged(address indexed _byWhom, address indexed _forWho, uint _oldAmount, uint _newAmount);
    
    //Modifiers 
    modifier enoughtMoneyGiven {
        require(msg.value > 0, "Not enought Allowance given (minimum 1 Wei)");
        _;
    }
    
    //Add allowance to someone
    function addAllowance(address _who) public payable enoughtMoneyGiven {
        emit AllowanceChanged(msg.sender, _who, OwnersAndBeneficiaries[msg.sender][_who].allowance, OwnersAndBeneficiaries[msg.sender][_who].allowance + msg.value);
        Beneficiaries memory thisBeneficiary = Beneficiaries(OwnersAndBeneficiaries[msg.sender][_who].numberOfAllowances++, OwnersAndBeneficiaries[msg.sender][_who].allowance + msg.value);
        OwnersAndBeneficiaries[msg.sender][_who] = thisBeneficiary;
        OwnersAndBeneficiaries[msg.sender][_who].numberOfAllowances = OwnersAndBeneficiaries[msg.sender][_who].numberOfAllowances + 1; 
    }
    
    //Get allowance of someone
    function getAllowance(address _owner, address _who) public view returns(uint) {
        return OwnersAndBeneficiaries[_owner][_who].allowance;
    }
    
    //Get balance of the smart contract 
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
}