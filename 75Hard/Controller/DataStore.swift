//
//  DataStore.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import Foundation

class DataStore: ObservableObject {

    @Published var challenges: [Challenge] = generateChallengeListPlaceholder()
    @Published var selectedChallengeIndex: Int = 0
    @Published var todaysChallengeDayIndex: Int = 0
    @Published var selectedChallengeDayIndex: Int = 0
    
    private var haveToCalculateSelectedChallengeDayIndex: Bool = true
    private let challengesKey = "challengeList"

    // Save challenge days to UserDefaults
    func saveChallenges() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.challenges)
            UserDefaults.standard.set(data, forKey: challengesKey)
            print("saved challenges")
        } catch {
            print("Error encoding challenge days: \(error)")
        }
    }

    // Load challenge days from UserDefaults
    func loadChallenges() {
        guard let data = UserDefaults.standard.data(forKey: challengesKey) else {
            print("no list saved -> generatingStandardList")
            challenges = generateChallengeList()
            saveChallenges()
            return
        }

        do {
            let decoder = JSONDecoder()
            let challenges = try decoder.decode([Challenge].self, from: data)
            self.challenges =  challenges
            print("loaded challenges")
        } catch {
            print("Error decoding challenge days: \(error)")
        }
    }
    
    func calculateSelectedChallengeIndex() -> Int {
        for index in challenges.indices {
            if (challenges[index].isSelected) {
                return index
            }
        }
        print("failed to calculate selectedChallengeIndex")
        return 0
    }
    
    func calculateTodaysChallengeDayIndex() -> Int {
        let todaysChallengeDay = Calendar.current.startOfDay(for: Date.now)
        for Index in 0..<challenges[selectedChallengeIndex].challengeDays.count {
            let tmpChallengeDay = Calendar.current.startOfDay(for: challenges[selectedChallengeIndex].challengeDays[Index].date)
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
        challenges[selectedChallengeIndex].challengeDays[index].allChallengeTasksCompleted
    }
    
    var selectedChallengeName: String {
        challenges[selectedChallengeIndex].name
    }
    var selectedChallengePhrase: String {
        challenges[selectedChallengeIndex].phrase
    }
}
