//
//  StatisticModel.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 20.07.2023.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
