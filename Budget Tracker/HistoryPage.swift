//
//  HistoryPage.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "All"
    let filterOptions: [String] = ["All", "Income", "Expense"]
    
    // Assuming transactions are defined elsewhere and accessible here
  let transactions: [Transaction]
    
    //Calculate the summary based on the selected filter
    var summary: Double {
            switch selectedFilter {
            case "Income":
                return transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
            case "Expense":
                return transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
            default:
                return transactions.reduce(0) { $0 + $1.amount }
            }
        }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search Transactions", text: $searchText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Filter Options
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filterOptions, id: \.self) { option in
                        Text(option).tag(option)
                            .font(.title2)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Summary
                HStack {
                    Text("Summary:")
                        .font(.title)
                    Spacer()
                    Text("$\(summary, specifier: "%.2f")")
                        .font(.title)
                }
                .padding(.horizontal)
                
                // Transaction List
                List(transactions) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.description)
                                .font(.headline)
                            Text(transaction.date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("$\(transaction.amount, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(transaction.type == .income ? .green : .red)
                    }
                    .padding()
                }
                .cornerRadius(10)
                .edgesIgnoringSafeArea(.bottom)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Transaction History", displayMode: .automatic)
            .navigationBarItems(leading: Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                        })
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        //  sample transactions array for the preview
        HistoryView(transactions: [
            Transaction(date: "08/08/2023", description: "Salary", amount: 1500.0, type: .income),
            Transaction(date: "08/07/2023", description: "Groceries", amount: -75.35, type: .expense),
            Transaction(date: "08/06/2023", description: "Bonus", amount: 200.0, type: .income),
                        Transaction(date: "08/05/2023", description: "Dining Out", amount: -50.0, type: .expense)
        ])
    }
}

