//
//  CryptoProBootcampApp.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 14.07.2023.
//

import SwiftUI

@main
struct CryptoProBootcampApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .environmentObject(vm)
        }
    }
}
