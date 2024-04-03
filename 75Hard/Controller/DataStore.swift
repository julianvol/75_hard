//
//  DataStore.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import Foundation
import HealthKit
import Observation

enum HealthError: Error {
    case healthDataNotAvailable
}

@Observable
class DataStore {
    static let shared = DataStore()
    private var healthStore = HKHealthStore()
    private var lastError: Error?

    private let key = "challengeDays"

    private init() {}

    // Save challenge days to UserDefaults
    func saveChallengeDays(_ challengeDays: [ChallengeDay]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(challengeDays)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error encoding challenge days: \(error)")
        }
    }

    // Load challenge days from UserDefaults
    func loadChallengeDays() -> [ChallengeDay] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return generateChallengeDays()
        }

        do {
            let decoder = JSONDecoder()
            let challengeDays = try decoder.decode([ChallengeDay].self, from: data)
            return challengeDays
        } catch {
            print("Error decoding challenge days: \(error)")
            return [] // TODO, maybe return ChallengesList with Loading symbols and other things...
        }
    }
}
