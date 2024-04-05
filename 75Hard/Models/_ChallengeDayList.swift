//
//  ChallengeDayList.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import Foundation

func generateChallengeDayList(challengeTasks: [ChallengeTask] = ChallengeTaskList_Standard, offset: Int = 0) -> [ChallengeDay] {
    
    var challengeDays: [ChallengeDay] = []
    // Create 75 ChallengeDay objects with dates incremented by one day starting today
    for i in 0..<75 {
        if let date = Calendar.current.date(byAdding: .day, value: i-offset, to: Calendar.current.startOfDay(for: Date())) {
            let challengeDay = ChallengeDay(date: date, challengeTasks: challengeTasks)
            challengeDays.append(challengeDay)
        }
    }
    return challengeDays
}

func generatePlaceholderChallengeDayList() -> [ChallengeDay] {
    
    var challengeDays: [ChallengeDay] = []
    // Create 75 ChallengeDay objects with dates incremented by one day starting today
    for i in 0..<75 {
        if let date = Calendar.current.date(byAdding: .day, value: i, to: Calendar.current.startOfDay(for: Date())) {
            let challengeDay = ChallengeDay(date: date, challengeTasks: ChallengeTaskListPlaceholder)
            challengeDays.append(challengeDay)
        }
    }
    return challengeDays
}
