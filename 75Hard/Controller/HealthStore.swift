//
//  HealthStore.swift
//  75Hard
//
//  Created by Julian Müller on 27.03.24.
//

import Foundation
import HealthKit

enum HealthError: Error {
    case healthDataNotAvailable
}

class HealthStore {
    
    let healthStore = HKHealthStore()
    
    func requestStepCountAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            if success {
                //print("Step count access granted")
            } else {
                //print("Error requesting step count access: \(error?.localizedDescription ?? "Unknown error")")
            }
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
