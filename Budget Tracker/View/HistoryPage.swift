//
//  HistoryPage.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//

import SwiftUI
/// `HistoryView` displaya a list of past transactions with search and filter options
struct HistoryView: View {
    
    @EnvironmentObject var vm:TransactionViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "All"
    let filterOptions: [String] = ["All", "Income", "Expense"]
    
    // Assuming transactions are defined elsewhere and accessible here
    //  let transactions: [Transaction]
    
    //Calculate the summary based on the selected filter
    var summary: Double {
        switch selectedFilter {
        case "Income":
            return vm.income
        case "Expense":
            return vm.expense
        default:
            return vm.income + vm.expense
        }
    }
    /// Filters transactions based on the selected filter
    var transactions: [TransactionModel] {
        switch selectedFilter {
        case "Income":
            return vm.transactions.filter({$0.isIncome})
        case "Expense":
            return vm.transactions.filter({!$0.isIncome})
        default:
            return vm.transactions
        }
    }
    /// Filters transactions based on the search text
    var filteredItems: [TransactionModel] {
        if searchText.isEmpty {
            return transactions
        } else {
            return transactions.filter { $0.detail?.localizedCaseInsensitiveContains(searchText) == true || $0.transType.title.localizedCaseInsensitiveContains(searchText) == true  }
        }
    }
    
    var body: some View {
        //        NavigationView {
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
            
            
            //                ScrollView {
            // Transactions List Section
            VStack(alignment: .leading) {
                if searchText.isEmpty {
                    if transactions.isEmpty {
                        Text("Transactions not Found")
                            .frame(width: 200, height: 40, alignment: .center)
                    } else {
                        List {
                            ForEach(transactions) { transaction in
                                TransactionRow(transaction: transaction)
                                    .frame(height: 80)
                                
                            }
                            .onDelete(perform: delete)
                        }
                        .background {
                            Color.clear
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                        
                    }
                } else {
                    if filteredItems.isEmpty {
                        Text("Transactions not Found")
                            .frame(width: 200, height: 40, alignment: .center)
                    } else {
                        List {
                            ForEach(filteredItems) { transaction in
                                TransactionRow(transaction: transaction)
                                    .frame(height: 80)
                            }
                            .onDelete(perform: delete)
                        }
                        .background {
                            Color.clear
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                        
                        
                    }
                }
                
                
            }
            
//            .padding()
            
            //                    .background(Color.white)
            //                    .cornerRadius(10)
            //                    .shadow(radius: 5)
            
            //                }
            //                .padding()
            Spacer()
        }
        
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { // Updated to customize navigation bar title
            ToolbarItem(placement: .principal) {
                Text("History")
                    .font(.title) // Increased font size
                    .fontWeight(.bold)
            }
            
            
        }
        
    }
    /// Allow the users to delete a transaction just by swipe left, also delete the transaction in CoreData
    func delete(at offsets: IndexSet) {
        let indices = Array(offsets)
        for index in indices {
            // Use the index to access the corresponding item in your collection
            let itemToDelete = vm.transactions[index]
            vm.didRemoveTransactions(transaction: itemToDelete)
           
        }

    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = TransactionViewModel()
        return HistoryView()
            .environmentObject(vm)
    }
}


