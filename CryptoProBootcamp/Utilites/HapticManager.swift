//
//  HapticManager.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 22.07.2023.
//

import SwiftUI

class HapticManager {
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
