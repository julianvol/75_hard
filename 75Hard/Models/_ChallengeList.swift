//
//  _ChallengeList.swift
//  75Hard
//
//  Created by Julian Müller on 03.04.24.
//

import Foundation

func generateChallengeList(offset: Int = 0) -> [Challenge] {
    
    var challenges: [Challenge] = []
    // Create 75 ChallengeDay objects with dates incremented by one day starting today
    let SampleChallenge = Challenge(name: "75Hard", phrase: "Strengthen your Body and Mind.", challengeDays: generateChallengeDayList(), isWeelkyChallenge: false, isSelected: true)
    let SampleChallenge1 = Challenge(name: "Template", phrase: "Template phrase.", challengeDays: generateChallengeDayList(challengeTasks: ChallengeTaskListTemplate), isWeelkyChallenge: false, isSelected: false) // TODO: remove this
    challenges.append(SampleChallenge)
    challenges.append(SampleChallenge1) // TODO: remove this
    return challenges
}

func generateChallengeListPlaceholder(offset: Int = 0) -> [Challenge] {
    
    var challenges: [Challenge] = []
    // Create 75 ChallengeDay objects with dates incremented by one day starting today
    let PlaceholderChallenge = Challenge(name: "Data unavailable", phrase: ".....", challengeDays: generatePlaceholderChallengeDayList(), isWeelkyChallenge: false, isSelected: true)
    challenges.append(PlaceholderChallenge)
    return challenges
}
