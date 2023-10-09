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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Picker("Select Type", selection: $selectedType) {
                ForEach(TransactionsType.allCases, id: \.self) { type in
                    Text(type.title).tag(type.rawValue)
                        .font(.title)
                        .foregroundColor(Color("blueCustom"))
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
                        .background(
                        
                            ZStack {
                                    if isIncomeType == .income {
                                        Color.blueCustom
                                    } else {
                                        Color.greyCustom
                                    }

                                    if colorScheme == .dark {
                                        Color.lightBlueCustom
                                    } else {
                                        Color.blueCustom
                                    }
                                }
                        
                        )
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .cornerRadius(10)
                        .fontWeight(.bold)
                }
                Button(action: { isIncomeType = .expense }) {
                    Text("Expense")
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .frame(maxWidth: .infinity)
                        .padding()
//                        .background(isIncomeType == .expense ? Color.redCustom : Color.greyCustom)
                        .background(
                        
                            ZStack {
                                    if isIncomeType == .income {
                                        Color.redCustom
                                    } else {
                                        Color.greyCustom
                                    }

                                    if colorScheme == .dark {
                                        Color.beigeCustom
                                    } else {
                                        Color.greyCustom
                                    }
                                }
                        
                        )
                        .cornerRadius(10)
                        .fontWeight(.bold)
                }
            }
            .padding()
            
            
            ZStack(alignment: .leading) {
                
                
                
            }
            
            Spacer().frame(height: 40)
            // Amount Section
            TextField("", text: $amount, prompt: Text("Amount").foregroundColor(.black.opacity(0.3)))
                .keyboardType(.decimalPad)
                .padding(20)
                .font(.title)
                .background(Color.white)
                .foregroundColor(.black)
//                .background(colorScheme == .dark ? Color.beigeCustom : Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
             
            
            
            // Description Section
            TextField("", text: $description, prompt: Text("Description").foregroundColor(.black.opacity(0.3)))
                .padding(20)
                .font(.title)
                .background(Color.white)
                .foregroundColor(.black)
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
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .dark ? Color.yellowCustom : Color.blueCustom)
                    .cornerRadius(10)
                    
            }
            .padding()
            Spacer()
            
        }
        
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color("BeigeToDarkBlue"), Color("YellowToMidBlue")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        
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
        Group {
            AddFundsView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
            
            AddFundsView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
