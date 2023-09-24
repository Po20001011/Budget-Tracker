//
//  SettingView.swift
//  Budget Tracker
//
//  Created by Wang Po on 15/8/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var notificationsEnabled = false
    @State private var selectedLanguage = "English"
    @State private var selectedCurrency = "USD"
    @State private var selectedDateFormat = "MM/dd/yyyy"
    @State private var selectedStartOfWeek = "Sunday"
    @State private var selectedBudgetReset = "Monthly"
    @State private var showEmail: Bool = false
    
    let languages = ["English", "Spanish", "French", "German", "Chinese"]
    let currencies = ["USD", "EUR", "GBP", "JPY", "CNY"]
    let dateFormats = ["MM/dd/yyyy", "dd/MM/yyyy", "yyyy-MM-dd"]
    let startOfWeekOptions = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let budgetResetOptions = ["Weekly", "Monthly", "Yearly"]
    
    var body: some View {
        VStack(spacing: 20) {

            userInfoSection
            generalSettingsSection
            notificationSettingsSection
            contactUsSection
            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .toolbar { // Updated to customize navigation bar title
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.title) // Increased font size
                    .fontWeight(.bold)
            }
            
            
        }
    }
    
    // MARK: - Navigation Bar
    var navigationBar: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            Spacer()
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
    }
    
    // MARK: - User Information Section
    var userInfoSection: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
            Text("User Name")
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
    }
    
    // MARK: - General Settings Section
    var generalSettingsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("General")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading)
            
            Form {
                Section {
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                    
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    
                    Picker("Date Format", selection: $selectedDateFormat) {
                        ForEach(dateFormats, id: \.self) { format in
                            Text(format)
                        }
                    }
                    
                    Picker("Start of Week", selection: $selectedStartOfWeek) {
                        ForEach(startOfWeekOptions, id: \.self) { day in
                            Text(day)
                        }
                    }
                    
                    Picker("Budget Reset", selection: $selectedBudgetReset) {
                        ForEach(budgetResetOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    // MARK: - Notification Settings Section
    var notificationSettingsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Notification Settings")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading)
            
            Toggle("Enable Notifications", isOn: $notificationsEnabled)
                .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    // MARK: - Contact Us Section
    var contactUsSection: some View {
        VStack {
            Button(action: {
                withAnimation {
                    showEmail.toggle()
                }
            }) {
                Text("Contact Us")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
            }
            .padding(.vertical, 10)
            
            if showEmail {
                Text("1234@gmail.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .transition(.opacity)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


