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
    
    // изменение цвета тайтла навигейшена
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
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
