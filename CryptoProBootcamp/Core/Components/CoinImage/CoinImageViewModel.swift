//
//  CoinImageViewModel.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 16.07.2023.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    
    private var cancellable = Set<AnyCancellable>()
    private let coin: CoinModel
    private let dataService: CoinImageService
    
    init(coin: CoinModel) {
        self.coin = coin
        dataService = CoinImageService(coin: coin)
        addSubscribers()
        isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _  in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellable)

    }
}
