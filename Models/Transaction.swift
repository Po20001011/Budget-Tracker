//
//  Transaction.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//
import Foundation

/// Represents a financial transaction with a date, description, amount, and type (income or expense).

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

