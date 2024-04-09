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
    
    @Binding var hasSetConsent: Bool
    let healthStore = HKHealthStore()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Welcome to 75Hard!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("We would like to access your devices health data for the step count challenge!")
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
                HStack {
                    Text("Manage Access")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(hasSetConsent ? .green : .gray)
                        .onTapGesture {
                            if (!hasSetConsent) {
                                requestHealthKitAuthorization()
                            }
                        }
                    Image(systemName: hasSetConsent ? "checkmark.circle.fill" : "pencil.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(hasSetConsent ? .green : .gray)
                }
                .padding(.leading)
                Spacer()
            }
            .padding(30)
            .onAppear {
                print("onAppear() -> ConsentScreen")
            }
            .onChange(of: hasSetConsent) {
                print("consent was set")
                if (hasSetConsent) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation() {
                            navigationState.changeScreen(to: .Home)
                        }
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation() {
                hasSetConsent = status == .sharingAuthorized || status == .sharingDenied
            }
        }
    }
}

#Preview {
    StepDataConsentScreen(hasSetConsent: .constant(true))
}
