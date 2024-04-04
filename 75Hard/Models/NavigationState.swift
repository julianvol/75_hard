//
//  NavigationState.swift
//  75Hard
//
//  Created by Julian Müller on 04.04.24.
//

import Foundation

class NavigationState: ObservableObject {
    @Published var currentScreen: Screen = Screen.Splash
    
    func changeScreen(to: Screen) {
        self.currentScreen = to
    }
}

enum Screen {
    case Splash
    case Consent
    case Home
    case Calendar
    case Select
}
