//
//  Transaction.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//
import Foundation

/// `Transaction` represents a financial transaction with a data, description, amount and type (income and expense)


struct Transaction: Identifiable {
    let id = UUID()
    let date: String
    let description: String
    let amount: Double
    let type: TransactionType
    
    enum TransactionType {
        case income
        case expense
    }
    



}

/// Enum representing types of transactions in the budget tracker.
/// This helps the user categorise their income and expenses.
enum TransactionsType: String,CaseIterable {
    case salary = "Salary"
    case bonus = "Bonus"
    case otherIncome = "Other Income"
    case groceries = "Groceries"
    case diningOut = "Dining Out"
    case drinks = "Drinks"
    case otherExpense = "Other Expense"
    
    
    var title:String {
        switch self {
        case .salary:
            return "Salary"
            
        case .bonus:
            return "Bonus"
            
        case .otherIncome:
             return "Other Income"
            
        case .groceries:
            return "Groceries"
            
        case .diningOut:
            return "Dining Out"
            
        case .drinks:
            return "Drinks"
            
        case .otherExpense:
            return "Other"
        }
        
    }
}

