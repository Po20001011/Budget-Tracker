//
//  ContentView.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//
import SwiftUI
struct HomePageView: View {
    var currentBalance: Double = 5321.45
    @State private var showAddFundsView: Bool = false
    @State private var showHistoryView: Bool = false
    
    @State private var transactions: [Transaction] = [
        Transaction(date: "08/08/2023", description: "Salary", amount: 1500.0, type: .income),
        Transaction(date: "08/07/2023", description: "Groceries", amount: -75.35, type: .expense),
        Transaction(date: "08/06/2023", description: "Bonus", amount: 300.0, type: .income),
        Transaction(date: "08/05/2023", description: "Rent", amount: -800.0, type: .expense),
        
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Current Balance Section
                    ZStack {
                        Circle()
                            .fill(RadialGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), center: .center, startRadius: 5, endRadius: 300))
                            .frame(width: 180, height: 180)
                            .shadow(radius: 10)
                        
                        VStack {
                            Text("Current Balance")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("$\(currentBalance, specifier: "%.2f")")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Transactions List Section
                    VStack(alignment: .leading) {
                        Text("Transactions")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        ForEach(transactions) { transaction in
                            HStack {
                                Text(transaction.type == .income ? "+" : "-") // Changed to display plus or minus
                                            .font(.headline)
                                            .foregroundColor(transaction.type == .income ? .green : .red)
                                    
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
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                }
                .padding()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            
            
            // Bottom Tab Bar with Four Buttons
            HStack {
                Button(action: {
                    
                    showAddFundsView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Funds")
                }
                .sheet(isPresented: $showAddFundsView) {
                    AddFundsView()
                }
                Spacer()
                Button(action: {
                    showHistoryView.toggle()
                }) {
                    Image(systemName: "clock.fill")
                    Text("History")
                } .sheet(isPresented: $showHistoryView) {
                    HistoryView(transactions: transactions) // Add this line
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "chart.bar.fill")
                    Text("Graph")
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "gearshape.fill")
                    Text("Setting")
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

