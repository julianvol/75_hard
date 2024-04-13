//
//  ChallengeDay.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import Foundation

struct ChallengeDay: Codable, Equatable {
    var date : Date
    var challengeTasks: [ChallengeTask]
    
    var allChallengeTasksCompleted: Bool {
        for challengeTask in challengeTasks {
            if !challengeTask.isCompleted {
                return false
            }
        }
        return true
    }
}
