//
//  ExchangeRates.swift
//  Budget Tracker
//
//  Created by Matthew Howatson on 27/9/2023.
//

import Foundation
/// ``ExchangeRate`` represents a single currency exchange rate
struct ExchangeRate: Codable {
    let currency: String
    let rate: Double
}
