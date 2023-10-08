//
//  SettingView.swift
//  Budget Tracker
//
//  Created by Wang Po on 15/8/2023.
// This is a test

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @FocusState var isInputActive: Bool
    @ObservedObject var networkManager = NetworkManager()
    @State private var amount: String = ""
    @State private var pickerSelection: Int = 0
    
    @State private var notificationsEnabled = false
    @State private var selectedLanguage = "English"
//    @State private var selectedCurrency = "USD"
    @State private var selectedDateFormat = "MM/dd/yyyy"
    @State private var selectedStartOfWeek = "Sunday"
    @State private var selectedBudgetReset = "Monthly"
    @State private var showEmail: Bool = false
    
    let languages = ["English", "Spanish", "French", "German", "Chinese"]
//    let currencies = ["USD", "EUR", "GBP", "JPY", "CNY"]
    let dateFormats = ["MM/dd/yyyy", "dd/MM/yyyy", "yyyy-MM-dd"]
    let startOfWeekOptions = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let budgetResetOptions = ["Weekly", "Monthly", "Yearly"]
    
    var total: Double {
        guard networkManager.exchangePrice.count > 0 else { return 0 }
        let buyingPrice = networkManager.exchangePrice[pickerSelection]
        let doubleAmount = Double(amount) ?? 0.0
        let totalAmount = buyingPrice * doubleAmount
        return totalAmount
    }
    
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
                .foregroundColor(Color.black)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
    }
    
    // MARK: - General Settings Section
    var generalSettingsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("General")
                .foregroundColor(Color.black)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading)
            
            Form {
                
                Section {
                    
                    HStack {
                        
                        Text("Currency Converter")
                        Spacer()
                        
                        Picker("", selection: $pickerSelection) {
                            ForEach(0..<networkManager.currencyCode.count, id: \.self) { index in
                                let currency = networkManager.currencyCode[index]
                                Text(currency)
                            }
                        }
                        
                        .id(UUID())
                        .labelsHidden()
                        
                    }
                    
                    HStack {
                        
                        TextField("Amount", text: $amount)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }

                        Text("\(total, specifier: "%.2f")")

                    }
                    
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                    
//                    Picker("Currency", selection: $selectedCurrency) {
//                        ForEach(currencies, id: \.self) { currency in
//                            Text(currency)
//                        }
//                    }
                    
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
                .foregroundColor(Color.black)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading)
            
            Toggle("Enable Notifications", isOn: $notificationsEnabled)
                .foregroundColor(Color.black)
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
        Group {
            SettingsView()
            .preferredColorScheme(.light)
            .previewDisplayName("Light Mode")
            
            SettingsView()
                .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
            
        }
        
    }
}


