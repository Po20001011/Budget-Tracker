//
//  NetworkManager.swift
//  Budget Tracker
//
//  Created by Matthew Howatson on 27/9/2023.
//

import SwiftUI



///  ``NetworkManager`` is a singleton class responsible for handling all network-related tasks in the Budget Tracker app.
///
/// ## Overview
/// The `NetworkManager` class provides methods for making API calls to fetch, create, update, and delete transactions. It uses the Singleton pattern to ensure that only one instance of the class is used throughout the app.
///
/// ## Usage
/// Use `NetworkManager.shared` to access the shared instance of the class and call its methods
class NetworkManager: ObservableObject {

    @Published var currencyCode: [String] = []
    @Published var exchangePrice: [Double] = []

    init() {
    }
    
    // I initially had the contents of the below function placed in the above init(), but this was creating too many calls to the API (between 8 or 9), and it was using up the limited amount of API requests for the free account. In the consulation, Mazen advised to put this code into it's own function - func initilizeCurrencyData() and then call it on the SettingView.swift file page. We did a test previously to see if the same amount of calls were being produced on the SettingsView.swift page, and they were only generating one call. It is now in the onAppear {} on the SettingsView.swift page
    
    func initilizeCurrencyData() {
                fetchCurrencyData { (currency) in
                    switch currency {
                    case .success(let prices):
                        // Filter and append only USD, EUR, GDP, JPY, CNY
                        let filteredRates = prices.conversion_rates.filter { ["USD", "EUR", "GBP", "JPY", "CNY"].contains($0.key) }
        
                        DispatchQueue.main.async {
                            self.currencyCode.append(contentsOf: filteredRates.keys)
                            self.exchangePrice.append(contentsOf: filteredRates.values)
                        }
        
                    case .failure(let error):
                        print("Failed to fetch currency data", error)
                    }
                }
    }
    
    
    private func fetchCurrencyData(completion: @escaping (Result<CurrencyData, Error>) -> ()) {

        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return }
        guard let mySecretApiKey: String = infoDictionary["MySecretApiKey"] as? String else { return }

        //  Used the line below to test is the API key was working
        print("Here's your api key value -> \(mySecretApiKey)")

        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(mySecretApiKey)/latest/AUD") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let safeData = data else { return }

            do {
                let currency = try JSONDecoder().decode(CurrencyData.self, from: safeData)
                completion(.success(currency))
            } catch {
                completion(.failure(error))

            }
        }.resume()
    }

}
