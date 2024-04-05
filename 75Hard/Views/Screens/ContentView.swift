//
//  ContentView.swift
//  75Hard
//
//  Created by Julian Müller on 04.04.24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    
    @State var hasGivenConsent: Bool = false
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            switch (navigationState.currentScreen) {
            case .Splash:
                SplashScreen() {
                    withAnimation {
                        navigationState.changeScreen(to: hasGivenConsent ? .Home : .Consent)
                    }
                }
            case .Consent:
                StepDataConsentScreen(hasGivenConsent: $hasGivenConsent)
            case .Home:
                HomeScreen()
            case .Calendar:
                CalendarScreen()
            case .Select:
                SelectChallengesScreen()
            }
        }
        .onAppear {
            print("onAppear() -> ContentView")
            updateHasGivenConsent()
            // prepareDataStore
        }
    }
    func updateHasGivenConsent() {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let status = healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .stepCount)!)
        hasGivenConsent = status == .sharingAuthorized || status == .sharingDenied
    }
}

#Preview {
    ContentView(hasGivenConsent: false)
}
