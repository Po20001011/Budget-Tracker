//
//  CurrencyData.swift
//  Budget Tracker
//
//  Created by Matthew Howatson on 27/9/2023.
//

import Foundation
/// ``CurrencyData`` represents the currency conversion rates fetched from an API
/// A dictionary containing currency codes as keys and their corresponding conversion rates as values.
    
struct CurrencyData: Codable {
    let conversion_rates : [String: Double]
}
