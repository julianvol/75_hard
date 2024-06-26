//
//  _5HardApp.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

@main
struct _5HardApp: App {
    @StateObject var navigationState = NavigationState()
    @StateObject var dataStore = DataStore()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationState)
                .environmentObject(dataStore)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                        dataStore.saveChallenges()
                }
                .onChange(of: scenePhase) {
                    if scenePhase == .background {
                        dataStore.saveChallenges()
                    }
                }
        }
    }
}
