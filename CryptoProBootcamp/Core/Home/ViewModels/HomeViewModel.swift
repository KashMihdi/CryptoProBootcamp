//
//  HomeViewModel.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 15.07.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText = ""
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        print(allCoins.count)
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
    }
}
