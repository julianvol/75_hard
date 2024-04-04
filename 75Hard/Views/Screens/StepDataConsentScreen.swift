//
//  StepDataConsentScreen.swift
//  75Hard
//
//  Created by Julian Müller on 02.04.24.
//

import SwiftUI
import HealthKit

struct StepDataConsentScreen: View {
    
    @EnvironmentObject var navigationState: NavigationState

    @Binding var hasGivenConsent: Bool
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            Text("Hello, we would like to access your devices health data for the step count challenge!")
                .padding(.bottom, 20)
            Button("Set access") {
                requestHealthKitAuthorization()
            }
        }
        .onAppear {
            print("onAppear() -> ConsentScreen")
            //updateHealthKitAuthorizationStatus()
        }
        .onChange(of: hasGivenConsent) {
            print("onChange")
            if (hasGivenConsent) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation() {
                        navigationState.changeScreen(to: .Home)
                        print("with animation")
                    }
                }
            }
        }
    }
    
    func requestHealthKitAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        healthStore.requestAuthorization(toShare: [], read: [stepCountType]) { (success, error) in
            updateHasGivenConsent()
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
    StepDataConsentScreen(hasGivenConsent: .constant(false))
}
