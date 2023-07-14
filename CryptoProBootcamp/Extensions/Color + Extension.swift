//
//  Color + Extension.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 14.07.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    /*
    в этом примере нужно к цветам образаться так Color.theme.background
    Но можно это улучшить вызвав все свойства в расширении вот так
     static let accent = Color("AccentColor")
     static let background = Color("BackgroundColor")
     static let green = Color("GreenColor")
     static let red = Color("RedColor")
     static let secondaryText = Color("SecondaryTextColor")
     
     Но в таком случае названия не должны совпадать с системными (red, green)
    */
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

