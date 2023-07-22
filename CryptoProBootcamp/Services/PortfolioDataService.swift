//
//  PortfolioDataService.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 22.07.2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                print("Error loading CoreData. \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching PortfolioEntity. \(error.localizedDescription)")
        }
    }
    
    // MARK: - PUBLIC
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // есть ли монета уже в портфолио
        if let entity = savedEntities.first(where: { $0.coinID == coin.id } ) {
            amount > 0 ? update(entity: entity, amount: amount) : delete(entity: entity)
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    // MARK: - PRIVATE
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData. \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
