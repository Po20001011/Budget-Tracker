//
//  AppTabView.swift
//  Budget Tracker
//
//  Created by Wang Po on 17/9/2023.
//

import SwiftUI

/// Represents the main tab view of the Budget Tracker app
///
/// This view contains tab for Home, Add Funds, History, Graph, and Setting


struct AppTabView: View {
    
    @State private var selectedTab = 0
    @State private var badgeValue = 0
    @StateObject var vm = TransactionViewModel()
 
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomePageView()
                    .environmentObject(vm)
            }
            .tabItem {
                Image(systemName: "dollarsign.circle.fill")
                   
                Text("Transactions")
                   
            }
            .tag(0)
            
            NavigationView {
                AddFundsView()
                    .environmentObject(vm)
            }
            .tabItem {
                Image(systemName: "plusminus.circle.fill")
                    
                Text("Add Funds")
                   
            }
            .tag(1)
            
            NavigationView {
                HistoryView()
                    .environmentObject(vm)
            }
            .tabItem {
                Image(systemName: "clock.fill")
                    
                Text("History")
                   
            }
            .tag(2)
            
            NavigationView {
                GraphView()
                    .environmentObject(vm)
            }
            .tabItem {
                Image(systemName: "circle.hexagongrid.circle.fill")
                    
                Text("Graph")
                   
            }
            .tag(3)
            
            NavigationView {
                SettingsView()
                    .environmentObject(vm)
            }
            .tabItem {
                Image(systemName: "gearshape.circle.fill")
                    
                Text("Settings")
                   
            }
            .tag(4)
            
        }
        .accentColor(.blue)
        .onChange(of: selectedTab) { _ in
            withAnimation {
                // Perform any additional animations or updates when the selected tab changes
            }
        }
        .onAppear {
            // correct the transparency bug for Tab bars
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            // correct the transparency bug for Navigation bars
//            let navigationBarAppearance = UINavigationBarAppearance()
//            navigationBarAppearance.configureWithOpaqueBackground()
//            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
    
    
    
}


