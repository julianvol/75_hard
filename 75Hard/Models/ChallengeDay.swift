//
//  ChallengeDay.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import Foundation

struct ChallengeDay: Codable {
    var date : Date
    var challenges: [Challenge]
    
    func allChallengesCompleted() -> Bool {
            for challenge in challenges {
                if !challenge.isCompleted {
                    return false
                }
            }
            return true
        }
}
