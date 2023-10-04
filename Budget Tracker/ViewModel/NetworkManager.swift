//
//  NetworkManager.swift
//  Budget Tracker
//
//  Created by Matthew Howatson on 27/9/2023.
//

import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var currencyCode: [String] = []
    @Published var exchangePrice: [Double] = []
    
    init() {
        fetchCurrencyData { (currency) in
            switch currency {
            case .success(let prices):
                // Filter and append only USD, EUR, GDP, JPY, CNY
                let filteredRates = prices.rates.filter { ["USD", "EUR", "GBP", "JPY", "CNY"].contains($0.key) }
                
                DispatchQueue.main.async {
                    self.currencyCode.append(contentsOf: filteredRates.keys)
                    self.exchangePrice.append(contentsOf: filteredRates.values)
                }
                
            case .failure(let error):
                print("Failed to fetch currency data", error)
            }
        }
        
    }
    
    func fetchCurrencyData(completion: @escaping (Result<CurrencyData, Error>) -> ()) {
//        This is a different API provider that ran out - keeping it here for reference which allowed for a base rate for AUD
//        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/5ab0432f8215601ffb47b189/latest/AUD") else { return }
        
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return }
        guard let mySecretApiKey: String = infoDictionary["MySecretApiKey"] as? String else { return }
        
//        Used the line below to test is the API key was working
//        print("Here's your api key value -> \(mySecretApiKey)")
        
        guard let url = URL(string: "https://api.ratesexchange.eu/client/latest?apikey=\(mySecretApiKey)") else { return }
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
