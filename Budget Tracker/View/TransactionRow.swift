//
//  TransactionRow.swift
//  Budget Tracker
//
//  Created by Wang Po on 22/9/2023.
//

import SwiftUI

/// Represents a single trsnaction row in the list
struct TransactionRow: View {
    
    var transaction:TransactionModel
    
    var body: some View {
        HStack {
            Text(transaction.isIncome ? "+" : "-") // Display plus or minus
                .font(.headline)
                .foregroundColor(transaction.isIncome ? .green : .red)
            VStack(alignment: .leading) {
                Text(transaction.detail ?? "aa")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(transaction.formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                /// Display the amount of the transaction
                Text("$\(transaction.amount, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(transaction.isIncome ? .green : .red)
                /// Display the type of the transaction
                Text(transaction.transType.title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            
        }
        .padding(.horizontal)
        .frame(height: 80)
    }
}
