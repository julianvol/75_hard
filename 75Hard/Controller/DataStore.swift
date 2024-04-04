//
//  DataStore.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import Foundation

class DataStore: ObservableObject {

    @Published var challengeConstructs: [ChallengeConstruct] = generatePlaceholderChallengeConstructList()
    @Published var selectedChallengeIndex: Int = 0
    @Published var todaysChallengeDayIndex: Int = 0
    @Published var selectedChallengeDayIndex: Int = 0
    
    private var haveToCalculateSelectedChallengeDayIndex: Bool = true
    private let challengesKey = "challengeList"

    // Save challenge days to UserDefaults
    func saveChallengeConstructs() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.challengeConstructs)
            UserDefaults.standard.set(data, forKey: challengesKey)
            print("saved challenges")
        } catch {
            print("Error encoding challenge days: \(error)")
        }
    }

    // Load challenge days from UserDefaults
    func loadChallengeConstructs() {
        guard let data = UserDefaults.standard.data(forKey: challengesKey) else {
            print("no list saved -> generatingStandardList")
            challengeConstructs = generateChallengeConstructList()
            saveChallengeConstructs()
            return
        }

        do {
            let decoder = JSONDecoder()
            let challengeConstructs = try decoder.decode([ChallengeConstruct].self, from: data)
            self.challengeConstructs =  challengeConstructs
            print("loaded challenges")
        } catch {
            print("Error decoding challenge days: \(error)")
        }
    }
    
    func calculateSelectedChallengeIndex() -> Int {
        for index in challengeConstructs.indices {
            if (challengeConstructs[index].isSelected) {
                return index
            }
        }
        print("failed to calculate selectedChallengeIndex")
        return 0
    }
    
    func calculateTodaysChallengeDayIndex() -> Int {
        let todaysChallengeDay = Calendar.current.startOfDay(for: Date.now)
        for Index in 0..<challengeConstructs[selectedChallengeIndex].challengeDays.count {
            let tmpChallengeDay = Calendar.current.startOfDay(for: challengeConstructs[selectedChallengeIndex].challengeDays[Index].date)
            if (tmpChallengeDay > todaysChallengeDay) { // start day lays in the furture
                return -1
            } else if (tmpChallengeDay == todaysChallengeDay) { // found todays day
                return Index
            }
        }
        return 75 // last day lays in the past
    }
    
    
    func calculateIndices(forceCalculateSelectedChallengeDayIndex: Bool = false) {
        selectedChallengeIndex = calculateSelectedChallengeIndex()
        todaysChallengeDayIndex = calculateTodaysChallengeDayIndex()
        if (haveToCalculateSelectedChallengeDayIndex || forceCalculateSelectedChallengeDayIndex) {
            haveToCalculateSelectedChallengeDayIndex = false
            selectedChallengeDayIndex = max(min(todaysChallengeDayIndex,74),0) // selectedIndex has to be in [0...74]
        }
    }
    
    func isDayComplete(index: Int) -> Bool {
        challengeConstructs[selectedChallengeIndex].challengeDays[index].allChallengesCompleted()
    }
    
    var selectedChallengeName: String {
        challengeConstructs[selectedChallengeIndex].name
    }
    var selectedChallengePhrase: String {
        challengeConstructs[selectedChallengeIndex].phrase
    }
}
