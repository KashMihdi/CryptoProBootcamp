//
//  CoinDataService.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 15.07.2023.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscriber: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        /*
        // Полный вызов метода по загрузке без использования NetworkingManager
         
        coinSubscriber = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscriber?.cancel()
            })
        */
        
        coinSubscriber = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscriber?.cancel()
            }
    }
}
