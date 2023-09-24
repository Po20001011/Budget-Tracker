//
//  AddFunds.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//

import SwiftUI

/// `AddFundsView` provides the user interface for adding new transactions
struct AddFundsView: View {
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm:TransactionViewModel
    @State private var amount: String = ""
    @State private var description: String = ""
    @State private var isIncomeType: IncomeType = .income
    @State private var selectedType: TransactionsType = .salary
    
    /// List of available transaction types
    let transactionTypes: [String] = ["Salary", "Gift", "Groceries", "Dining Out", "Other"]
    
    // MARK: - Body
    
    var body: some View {

            VStack(spacing: 20) {
                
                Picker("Select Type", selection: $selectedType) {
                    ForEach(TransactionsType.allCases, id: \.self) { type in
                        Text(type.title).tag(type.rawValue)
                            .font(.title)
                    }
                }
                .padding(.horizontal)
                .frame(width: 180,height: 60)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                HStack { // Transaction Type Section
                    Button(action: { isIncomeType = .income }) {
                        Text("Income")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isIncomeType == .income ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: { isIncomeType = .expense }) {
                        Text("Expense")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isIncomeType == .expense ? Color.red : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer().frame(height: 40)
                // Amount Section
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    .padding(20)
                    .font(.title)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                // Description Section
                TextField("Description", text: $description)
                    .padding(20)
                    .font(.title)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                Button(action: {
                    if let amount = Double(amount) {

                    vm.didAddTransaction(amountt: amount, detail: description, isIncome: isIncomeType == .income, type: selectedType)
                        self.amount = ""
                        description = ""
                        // Calls the didAddTransaction method from the TransactionViewModel to add a new transaction with the provided details
                    }
                   
              }) {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.6, green: 1.0, blue: 0.6))
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
                
            }
            
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
       
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // Updated to customize navigation bar title
                ToolbarItem(placement: .principal) {
                    Text("New Transaction")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                
            }

    }
    
    // MARK: - Enums
    enum IncomeType {
        case income
        case expense
    }
}
// MARK: - Preview

/// Preview provider for `AddFundsView`
struct AddFunds_Previews: PreviewProvider {
    static var previews: some View {
        AddFundsView()
    }
}


