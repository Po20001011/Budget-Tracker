//
//  TransactionModel+CoreDataProperties.swift
//  Budget Tracker
//
//  Created by Wang Po on 22/9/2023.
//

import Foundation
import CoreData

/// Extension to add Core Data properties and computed properties to the TransactionModel
extension TransactionModel {
    
    /// Fetch request for TransactionModel entity
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionModel> {
        return NSFetchRequest<TransactionModel>(entityName: "TransactionModel")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var isIncome: Bool
    @NSManaged public var amount: Double
    @NSManaged public var detail: String?
    @NSManaged public var type: String?
    
}
/// Add Identifiable conformance and computed properties
extension TransactionModel : Identifiable {
    
    
    var formattedDate:String {
        let df = DateFormatter()
        df.dateStyle = .short
        return df.string(from: date!)
    }
    
    var transType:TransactionsType {
        return TransactionsType(rawValue: type ?? "") ?? .salary
    }
    
    var monthYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy" // Month and year format
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
