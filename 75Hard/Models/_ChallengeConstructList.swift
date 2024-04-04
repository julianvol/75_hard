//
//  _ChallengeConstructList.swift
//  75Hard
//
//  Created by Julian Müller on 03.04.24.
//

import Foundation

func generateChallengeConstructList(offset: Int = 0) -> [ChallengeConstruct] {
    
    var challengeConstructs: [ChallengeConstruct] = []
    // Create 75 ChallengeDay objects with dates incremented by one day starting today
    let SampleChallenge = ChallengeConstruct(name: "75Hard", phrase: "Strengthen your Body and Mind.", challengeDays: generateChallengeDayList(), isWeelkyChallenge: false, isSelected: true)
    let SampleChallenge1 = ChallengeConstruct(name: "Template", phrase: "Template phrase.", challengeDays: generateChallengeDayList(challengeTasks: ChallengeListTemplate), isWeelkyChallenge: false, isSelected: false) // TODO: remove this
    challengeConstructs.append(SampleChallenge)
    challengeConstructs.append(SampleChallenge1) // TODO: remove this
    return challengeConstructs
}

func generatePlaceholderChallengeConstructList(offset: Int = 0) -> [ChallengeConstruct] {
    
    var challengeConstructs: [ChallengeConstruct] = []
    // Create 75 ChallengeDay objects with dates incremented by one day starting today
    let PlaceholderChallenge = ChallengeConstruct(name: "Data unavailable", phrase: ".....", challengeDays: generatePlaceholderChallengeDayList(), isWeelkyChallenge: false, isSelected: true)
    challengeConstructs.append(PlaceholderChallenge)
    return challengeConstructs
}
