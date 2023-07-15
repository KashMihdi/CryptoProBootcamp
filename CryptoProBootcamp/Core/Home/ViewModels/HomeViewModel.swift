//
//  HomeViewModel.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 15.07.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.allCoins.append(DeveloperPreview.instance.coin)
            self?.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
