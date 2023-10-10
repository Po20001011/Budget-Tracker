//
//  TransactionViewModel.swift
//  Budget Tracker
//
//  Created by Wang Po on 22/9/2023.
//

import SwiftUI

/// Manages and provides data for transactions in the Budget Tracker app
class TransactionViewModel:ObservableObject {
    // MARK: - Properties
    
    /// Shared instance of CoreDataManager for database operations
    public let manager = CoreDataManager.shared
    
    @Published var date = Date()
    
    /// Array of transaction. Recalculates the current balance when modified
    @Published var transactions:[TransactionModel] = [] {
        didSet {
            let income = transactions.filter({$0.isIncome}).map({$0.amount}).reduce(0, +)
            let expense = transactions.filter({!$0.isIncome}).map({$0.amount}).reduce(0, +)
            currentBalance = income - expense
        }
    }
    
    var income:Double {
        return  transactions.filter({$0.isIncome}).map({$0.amount}).reduce(0, +)
    }
    
    var expense:Double {
        return  transactions.filter({!$0.isIncome}).map({$0.amount}).reduce(0, +)
    }
    
    @Published var monthlyTransaction:[TransactionModel] = []
    
    @Published var currentBalance:Double = 0
    
    @Published var selectedMonth = "January" {
        didSet {
            getTransactionBy()
        }
    }
    
    // MARK: - Initialization
    
    /// Initializes the view model and fetches all transaction
    init() {
        selectedMonth = date.toString(format: "MMMM")
        transactions = manager.getAllTransaction()
    }
    
    // MARK: - Methods
    /// Fetches transactions for the selected month and year
    
    func getTransactionBy() {
        let year = date.toString(format: "yyyy")
        let key = "\(selectedMonth) \(year)"
        monthlyTransaction = manager.groupTransactionsByMonth()[key] ?? []
    }
    
    
    
    
    
}
extension TransactionViewModel {
    
    /// Adds a new transaction
    func didAddTransaction(amountt:Double,detail:String,isIncome:Bool,type:TransactionsType) {
        let transaction = manager.createTransaction(detail: detail, amount: amountt, isIncome: isIncome, type: type.title)
        self.transactions.insert(transaction, at: 0)
        getTransactionBy()
    }
    
    /// Removes a transaction
    func didRemoveTransactions(transaction:TransactionModel) {
        if let index = transactions.firstIndex(of: transaction) {
            let trans = transactions[index]
            transactions.remove(at: index)
            manager.removeTransaction(tran: trans)
            getTransactionBy()
        }
       
    }
}
  



extension Date {
    
    func toString(format:String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_AU") // Australian locale
        df.dateFormat = format
        return df.string(from: self)
    }
}

