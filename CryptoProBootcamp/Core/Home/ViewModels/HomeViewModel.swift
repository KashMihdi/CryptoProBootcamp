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
    }
    
    func addSubscribers() {
        /*
         // старая подписка на получение данных из сети при помощи CoinDataService
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
        */
        
        // подписка для передачи массива из сети и фильтрация его при помощи поисковой строки
        // замена функции сверху в комментарии
        $searchText
            .combineLatest(dataService.$allCoins)
        // добавляем задержку для поисковой строки
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text, startingCoins -> [CoinModel] in
                guard !text.isEmpty else { return startingCoins }
                let lowercasedText = text.lowercased()
                
                return startingCoins.filter {
                    $0.name.lowercased().contains(lowercasedText) ||
                    $0.symbol.lowercased().contains(lowercasedText) ||
                    $0.id.lowercased().contains(lowercasedText)
                }
            }
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
    }
}
