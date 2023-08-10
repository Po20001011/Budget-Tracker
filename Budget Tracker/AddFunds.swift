//
//  AddFunds.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//

import SwiftUI

struct AddFundsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var amount: String = ""
    @State private var description: String = ""
    @State private var transactionType: TransactionType = .income
    @State private var selectedType: String = "Salary"
    
    let transactionTypes: [String] = ["Salary", "Gift", "Groceries", "Dining Out", "Other"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Select Type of Transaction
                Picker("Select Type", selection: $selectedType) {
                    ForEach(transactionTypes, id: \.self) { type in
                        Text(type).tag(type)
                            .font(.title)
                    }
                }
                .padding(.horizontal, 100)
                .frame(height: 100)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                HStack { // Transaction Type Section
                    Button(action: { transactionType = .income }) {
                        Text("Income")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(transactionType == .income ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: { transactionType = .expense }) {
                        Text("Expense")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(transactionType == .expense ? Color.red : Color.gray)
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
                    // Handle the submission of the amount and description
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
                        .font(.title) // Increased font size
                        .fontWeight(.bold)
                }
                
                
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
            })
        }
    }
    enum TransactionType {
        case income
        case expense
    }
}


struct AddFunds_Previews: PreviewProvider {
    static var previews: some View {
        AddFundsView()
    }
}

