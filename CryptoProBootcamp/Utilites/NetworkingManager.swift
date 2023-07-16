//
//  NetworkingManager.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 16.07.2023.
//

import Foundation
import Combine

/*
это слой создан для принятия данных и разгрузки CoinDataService
*/

class NetworkingManager {
    /*
    создание собственной ошибки
     подписываем на протокол LocalizedError, так как он сразу даст описание ошибки из свойства errorDescription
    */
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[!] Bad response from URL \(url)"
            case .unknown: return "[🥲]Unknown error occurred"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
        /*
         модификатор который говорит что можно вернуть любого Publisher
         поэтому тип возвращаемого выражения будет AnyPublisher<Data,Error>
         */
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output:  URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case .failure(let error): print(error.localizedDescription)
        }
    }
    
}
