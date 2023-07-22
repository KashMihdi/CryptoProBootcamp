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
    @Published var statistics: [StatisticModel] = []
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
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
            .combineLatest(coinDataService.$allCoins)
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
        
        /*
        подписка для заполнения массива statistics, который отображает краткую инормацию вверху главной страницы по капитализации
         для нее создан отдельный файл для загрузки данных MarketDataService
        */
        marketDataService.$marketData
            .map( mapGlobalMarketData )
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellable)
        
        /*
        обновляем данные для portfolioCoins
        */
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { coinModels, portfolioEntities -> [CoinModel] in
                coinModels
                    .compactMap { coin -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellable)
            
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    // вспомогательная функция
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24H Volume", value: data.volime)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
}
