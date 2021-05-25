# WalletWithAllowances

This smart contract allows you to give pocket money to one or more people. This smart contract stores the money. It is possible for the donor of the money to get his money back. It is also possible for the recipient of the pocket money to get his money back.

## Functions 

### addAllowance

Allows you to give pocket money to a recipient.

### getAllowance

Allows you to obtain the amount of pocket money of a person based on their address and the address of the person who gave them the pocket money.

### getBalance

Allows you to obtain the total amount of money stored on the smart contract.

### withdrawMoneyToBeneficiary

Allows, when you are a beneficiary, to recover an amount of pocket money. You must enter your address as a beneficiary, the address of the person who gave you the pocket money and the amount you want to withdraw.

### withdrawMoneyFromOwner

Allows, when you have given your money to a beneficiary, to recover an amount of this money given. You have to fill in your address as the owner, the address of the beneficiary to whom you have given pocket money and the amount you want to withdraw.
