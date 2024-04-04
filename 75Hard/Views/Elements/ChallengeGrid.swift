//
//  ChallengeGrid.swift
//  75Hard
//
//  Created by Julian Müller on 31.03.24.
//

import SwiftUI

struct ChallengeGrid: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    //@Binding var challengeDays: [ChallengeDay]
    @Binding var stepCounts: [Int]
    //@Binding var selectedChallengeDayIndex: Int
    
    //let saveChanges: () -> Void // Closure to handle tap action
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], spacing: 15) {
            ForEach(dataStore.challengeConstructs[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challenges.indices, id: \.self) { challengeIndex in
                ChallengeElement(challenge: $dataStore.challengeConstructs[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challenges[challengeIndex], stepCount: stepCounts.count == 75 ? $stepCounts[dataStore.selectedChallengeDayIndex] : .constant(0), allowTap: dataStore.challengeConstructs[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].date == Calendar.current.startOfDay(for: Date()), saveChanges: {
                    dataStore.saveChallengeConstructs()
                })
            }
        }
    }
    /*
    private func challengeBinding(for index: Int) -> Binding<Challenge> {
        Binding(
            get: { dataStore.challengeConstructs[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challenges[index] },
            set: { dataStore.challengeConstructs[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challenges[index] = $0 }
        )
    }
     */
}
/*
 #Preview {
 ChallengeGrid(challengeDays: Binding<[ChallengeDay]>(get: {
 return generateChallengeDayList()
 }, set: { newValue in
 }), stepCounts: .constant(Array(repeating: 0, count: 75)), selectedChallengeDayIndex: .constant(1), saveChanges: {})
 }
 */
