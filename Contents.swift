//: Playground - noun: a place where people can play

import UIKit

enum accountOperation: Error {
    case withDrawByZero
    case withDrawByMinus
    case withDrawOverflow
    case depositTooMuch
    
}

protocol CanTransfer {
    
}

class Client: CanTransfer {
    let id: Int
    var bankAccount: BankAccount
    public init (_ id: Int, _ bankAccount: BankAccount) {
        self.id = id;
        self.bankAccount = bankAccount
    }
}

class IndividualPerson: Client {
    var name: String
    var surname: String
    
    init(name: String, surname: String, id: Int, bankAccount: BankAccount) {
        self.name = name
        self.surname = surname
        super.init(id, bankAccount)
    }
}

class LegalPerson: Client {
    var name: String
    var typeOrganization: String
    
    init(name: String, typeOrganization: String, id: Int, bankAccount: BankAccount) {
        self.name = name
        self.typeOrganization = typeOrganization
        super.init(id, bankAccount)
    }

}

protocol Shifting {
    func transfer(from: CanTransfer, moneyValue: Int, account: BankAccount)
}

class Bank: Shifting, CanTransfer {
    var from: CanTransfer
    var moneyValue: Int
    var account: BankAccount
    init(from: CanTransfer, moneyValue: Int,
     account: BankAccount) {
      
        self.from = from
        self.moneyValue = moneyValue
        self.account = account
    }
    
    
    func transfer(from: CanTransfer, moneyValue: Int, account: BankAccount) {
        
    }
}

struct BankAccount {
    let id: Int
    var balance : Int
    
   mutating func withDraw(_ value: Int) throws -> Int {
        if value > balance {
            throw accountOperation.withDrawOverflow
        }
        
        if value == 0 {
            throw accountOperation.withDrawByZero
        }
        
        if value < 0 {
            throw accountOperation.withDrawByMinus
        }
        
        return balance - value
    }
    
    mutating func deposit(value: Int) throws {
        if value > 200000 {
            throw accountOperation.depositTooMuch
        }
        balance += value
    }
    
}