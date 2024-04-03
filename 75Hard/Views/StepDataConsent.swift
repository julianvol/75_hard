//
//  StepDataConsent.swift
//  75Hard
//
//  Created by Julian Müller on 02.04.24.
//

import SwiftUI
import HealthKit

struct StepDataConsent: View {
    
    @State private var healthKitAuthorizationStatus: HKAuthorizationStatus = .notDetermined
    let healthStore = HKHealthStore()


    var body: some View {
        VStack {
            if (healthKitAuthorizationStatus == .sharingAuthorized || healthKitAuthorizationStatus == .sharingDenied) {
                ContentView()
            } else {
                Text("Hello, we would like to access your devices health data for the step count challenge!")
                    .padding(.bottom, 20)
                Button("Set access") {
                    requestHealthKitAuthorization()
                }
            }
        }
        .onAppear {
            updateHealthKitAuthorizationStatus()
        }
    }
    
    func requestHealthKitAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        healthStore.requestAuthorization(toShare: [], read: [stepCountType]) { (success, error) in
            updateHealthKitAuthorizationStatus()
        }
    }
    func updateHealthKitAuthorizationStatus() {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let status = healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .stepCount)!)
        DispatchQueue.main.async {
            healthKitAuthorizationStatus = status
        }
    }
}

#Preview {
    StepDataConsent()
}
