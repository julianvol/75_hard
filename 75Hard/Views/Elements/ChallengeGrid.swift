//
//  ChallengeGrid.swift
//  75Hard
//
//  Created by Julian Müller on 31.03.24.
//

import SwiftUI

struct ChallengeGrid: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    @Binding var stepCounts: [Int]
        
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], spacing: 15) {
            ForEach(dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challengeTasks.indices, id: \.self) { challengeTaskIndex in
                ChallengeTaskElement(challengeTask: $dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challengeTasks[challengeTaskIndex], stepCount: stepCounts.count == 75 ? $stepCounts[dataStore.selectedChallengeDayIndex] : .constant(0), allowTap: dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].date == Calendar.current.startOfDay(for: Date()), saveChanges: {
                    //dataStore.saveChallenges()
                })
            }
        }
    }
}

#Preview {
    ChallengeGrid(stepCounts: .constant(Array(repeating: 0, count: 75)))
}
 
