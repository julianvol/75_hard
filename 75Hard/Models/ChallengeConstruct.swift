//
//  ChallengeConstruct.swift
//  75Hard
//
//  Created by Julian Müller on 03.04.24.
//

import Foundation

struct ChallengeConstruct: Codable {
    var name: String
    var phrase: String
    var challengeDays: [ChallengeDay]
    var isWeelkyChallenge: Bool
    var isSelected: Bool
    
    mutating func reset(withOffset: Int = 0) {
        for challengeDayIndex in 0..<75 {
            if let date = Calendar.current.date(byAdding: .day, value: challengeDayIndex-withOffset, to: Calendar.current.startOfDay(for: Date())) {
                challengeDays[challengeDayIndex].date = date
                for challengeIndex in challengeDays[challengeDayIndex].challenges.indices {
                    challengeDays[challengeDayIndex].challenges[challengeIndex].isCompleted = false
                }
            }
        }
    }
}
