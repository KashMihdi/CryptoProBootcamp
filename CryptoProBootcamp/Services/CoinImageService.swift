//
//  CoinImageService.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 16.07.2023.
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageCancellable: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageCancellable = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageCancellable?.cancel()
            }

    }
}
