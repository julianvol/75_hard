//
//  ChallengeTaskGrid.swift
//  75Hard
//
//  Created by Julian Müller on 31.03.24.
//

import SwiftUI

struct ChallengeTaskGrid: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    @Binding var stepCount: Int
        
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], spacing: 15) {
            ForEach(dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challengeTasks.indices, id: \.self) { challengeTaskIndex in
                ChallengeTaskElement(challengeTask: $dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].challengeTasks[challengeTaskIndex], stepCount: $stepCount, allowTap: dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].date == Calendar.current.startOfDay(for: Date()))
            }
        }
    }
}

#Preview {
    ChallengeTaskGrid(stepCount: .constant(9999))
}
 
