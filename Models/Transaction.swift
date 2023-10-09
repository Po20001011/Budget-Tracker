//
//  Transaction.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//
import Foundation

/// `Transaction` represents a financial transaction with a data, description, amount adn type (income and expense)
// This is an example of documentation that I will be doing in the end of project development

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
/// This helps the user categorize their income and expenses.
enum TransactionsType:Int16,CaseIterable {
    case salary
    case gift
    case groceries
    case diningOut
    case other
    
    var title:String {
        switch self {
        case .salary:
            return "Salary"
        case .gift:
            return "Gift"
        case .groceries:
            return "Groceries"
        case .diningOut:
            return "Dining Out"
        case .other:
            return "Other"
        }
        
    }
}

