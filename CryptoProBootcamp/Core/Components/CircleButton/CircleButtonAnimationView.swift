//
//  CircleButtonAnimationView.swift
//  CryptoProBootcamp
//
//  Created by Kasharin Mikhail on 15.07.2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.5)
            .opacity(animate ? 0 : 1.0)
        /*
        добавляя анимацию мы хотим чтобы она анимировалась только при изменении с false на true, поэтому используем тернарный чтобы отключить анимации с true на false
        */
            .animation(animate ? .easeInOut(duration: 0.7) : .none, value: animate)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(true))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}
