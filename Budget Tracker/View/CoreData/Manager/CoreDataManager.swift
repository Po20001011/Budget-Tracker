//
//  CoreDataManager.swift
//  Budget Tracker
//
//  Created by Wang Po on 22/9/2023.
//

import Foundation
import CoreData

/// `CoreDataManager` is a singleton class that manages Core Data operations
///
///  ## OverView 
///  The `CoreDataManager` class is responsible for managing Core Data operations such as fetching, creating , and deleting transactions
class CoreDataManager {
    
    static let shared = CoreDataManager()
    lazy var coreDataStack = CoreDataStack(modelName: "BudgetTrackerModel")
    
    private init() {
        
    }
    
}

// MARK: - Transaction Management

extension CoreDataManager {
    /// Fetches all transactions sorted by date in descenging order
    func getAllTransaction() -> [TransactionModel] {
        let request:NSFetchRequest<TransactionModel> = TransactionModel.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(TransactionModel.date), ascending: false)
        request.sortDescriptors = [sort]
        do {
            let files = try coreDataStack.managedContext.fetch(request)
            return files
        } catch {
            print("Unable to Fetch Journey, (\(error))")
        }
        return []
    }
    
  

  
    /// Creates a new transaction and  saves it to the database
    @discardableResult
    func createTransaction(detail: String, amount: Double, isIncome: Bool, type: String) -> TransactionModel {
        let transaction = TransactionModel(context: coreDataStack.managedContext)
        transaction.date = Date()
        transaction.amount = amount
        transaction.detail = detail
        transaction.isIncome = isIncome
        transaction.type = type
        coreDataStack.saveContext()
        return transaction
    }
    /// Removes a transaction from the database
    func removeTransaction(tran:TransactionModel) {
        coreDataStack.managedContext.delete(tran)
        coreDataStack.saveContext()
    }
    
 
}

// MARK: - Grouping Transactions
extension CoreDataManager {
    
    /// Groups transaction by month and year
    /// Return: A dictionary where the key is the month and year, and the value is an array of transactions for that month
    func groupTransactionsByMonth() -> [String: [TransactionModel]] {
           var groupedTransactions: [String: [TransactionModel]] = [:]

           for transaction in getAllTransaction() {
               if let date = transaction.date {
                   let calendar = Calendar.current
                   let components = calendar.dateComponents([.year, .month], from: date)
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "MMMM yyyy" // Month and year format
                   let monthYear = dateFormatter.string(from: calendar.date(from: components)!)

                   if var transactionsInMonth = groupedTransactions[monthYear] {
                       transactionsInMonth.append(transaction)
                       groupedTransactions[monthYear] = transactionsInMonth
                   } else {
                       groupedTransactions[monthYear] = [transaction]
                   }
               }
           }

           return groupedTransactions
       }
}
