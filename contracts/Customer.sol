pragma solidity ^0.4.2;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./helpers/AvoidRecursiveCall.sol";
import "./CoinSale.sol";
import "./Registrator.sol";
import "./Registered.sol";


contract Customer is Registered, Ownable, AvoidRecursiveCall {
    
    address[] public wallets;
    uint256[] public transactions; // txid[]

    event WalletAdded(address wallet);
    event TransactionAdded(uint256 txid);

    function Customer(Registrator registratorArg) Registered(registratorArg) {
    }

    function walletsCount() constant returns(uint) {
        return wallets.length;
    }

    function transactionsCount() constant returns(uint) {
        return transactions.length;
    }

    function addWallet(address wallet) avoidRecursiveCall onlyRegistrator {
        for (uint i = 0; i < wallets.length; i++) {
            require(wallets[i] != wallet);
        }
        wallets.push(wallet);
        WalletAdded(wallet);
    }

    function addTransaction(uint256 txid) avoidRecursiveCall onlyRegistrator {
        for (uint i = 0; i < transactions.length; i++) {
            require(transactions[i] != txid);
        }
        transactions.push(txid);
        TransactionAdded(txid);
    }

}
