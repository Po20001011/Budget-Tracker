//
//  ContentView.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//
//

import SwiftUI

/// Represents the home page view of the Budget Tracker app
///
///  This view displays the current balance and a list of transactions. It also provides options to navigate to different sections of the app
struct HomePageView: View {
    
    // MARK: - Properties
    
    /// The view model for managing transactions
    @EnvironmentObject var vm:TransactionViewModel
    
    var currentBalance: Double = 5321.45
    
    /// State variables for showing different views
    @State private var showAddFundsView: Bool = false
    @State private var showHistoryView: Bool = false
    @State private var showGraphView: Bool = false
    @State private var showSettingsView: Bool = false
    
    // MARK: - Body
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 20) {
                // Current Balance Section
                ZStack {
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color("MidBlueToYellow"), Color("DarkBlueToBeige")]), center: .center, startRadius: 5, endRadius: 300))
                        .frame(width: 180, height: 180)
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("Current Balance")
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                        // Display the current balance fetched from the view model
                        Text("$\(vm.currentBalance, specifier: "%.2f")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                    }
                }
                
                ScrollView {
                    // Transactions List Section
                    VStack(alignment: .leading) {
                        if vm.transactions.isEmpty {
                            Text("No record Press + to add")
                                .frame(width: 200, height: 40, alignment: .center)
                                .foregroundColor(colorScheme == .dark ? .blue : .orange) // set text color
                                

                        } else {
                            
                            ForEach(vm.transactions) { transaction in
                                TransactionRow(transaction: transaction)
                                    
                            }
                        }

                    }

                    .background(Color.white)
                    .cornerRadius(10)
 
                }
                
                .shadow(radius: 5)
                .padding()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // Updated to customize navigation bar title
                ToolbarItem(placement: .principal) {
                    Text("Transaction")
                        .font(.title) // Increased font size
                        .fontWeight(.bold)
                }
 
            }
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("BeigeToDarkBlue"), Color("YellowToMidBlue")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all).frame(width: UIScreen.main.bounds.width))

    }
}

// MARK: - Preview
/// Preview provider for ``ContentView_Previews``
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomePageView()
                .environmentObject(TransactionViewModel())
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")

            HomePageView()
                .environmentObject(TransactionViewModel())
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}


