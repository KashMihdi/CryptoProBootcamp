//
//  MarketDataService.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 21.07.2023.
//

import Foundation
import Combine


/*
класс по загрузке статистических данных из интеренета
*/
class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscriber: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscriber = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscriber?.cancel()
            }
    }
}
