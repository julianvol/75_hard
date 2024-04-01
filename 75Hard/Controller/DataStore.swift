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
            return []
        }
    }
    
    func requestStepCountAuthorization() async {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else { return }
        do {
            try await healthStore.requestAuthorization(toShare: [], read: [stepType])
        } catch {
            lastError = error
        }
        
    }
    
    func fetchStepCounts(startDate: Date) async throws -> [Int] {
                
        let dataDifference = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day!
        
        let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -dataDifference, to: Date())!)
        let endDate = Calendar.current.date(byAdding: .day, value: 74, to: Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startDate)!)!

        let stepType = HKQuantityType(.stepCount)
        let everyDay = DateComponents(day:1)
        let timeFrame = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let stepsInTimeFrame = HKSamplePredicate.quantitySample(type: stepType, predicate: timeFrame)
        
        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: stepsInTimeFrame, options: .cumulativeSum, anchorDate: startDate, intervalComponents: everyDay)
        
        let stepsCount = try await sumOfStepsQuery.result(for: healthStore)
        
        var stepCounts: [Int] = Array(repeating: 0, count: 75)

        stepsCount.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            if let sum = statistics.sumQuantity() {
                let stepCount = Int(sum.doubleValue(for: HKUnit.count()))
                // Determine the index based on the date difference
                let index = Calendar.current.dateComponents([.day], from: startDate, to: statistics.startDate).day!
                // Update the stepCounts array at the corresponding index
                stepCounts[index] = stepCount
            }
        }
        return stepCounts
    }

}
