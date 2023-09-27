//
//  ExchangeRates.swift
//  Budget Tracker
//
//  Created by Matthew Howatson on 27/9/2023.
//

import Foundation

struct ExchangeRate: Codable {
    let currency: String
    let rate: Double
}
