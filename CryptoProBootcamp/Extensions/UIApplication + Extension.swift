//
//  UIApplication + Extension.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 20.07.2023.
//

import SwiftUI

/*
расширение для скрытия клавиатуры
*/
extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
