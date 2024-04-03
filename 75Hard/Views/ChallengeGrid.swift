//
//  ChallengeGrid.swift
//  75Hard
//
//  Created by Julian Müller on 31.03.24.
//

import SwiftUI

struct ChallengeGrid: View {
    @Binding var challengeDays: [ChallengeDay]
    @Binding var stepCounts: [Int]
    @Binding var selectedChallengeDayIndex: Int
        
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], spacing: 15) {
            ForEach($challengeDays[selectedChallengeDayIndex].challenges.indices, id: \.self) { challengeIndex in
                ChallengeElement(challenge: challengeBinding(for: challengeIndex), stepCount: stepCounts.count == 75 ? $stepCounts[selectedChallengeDayIndex] : .constant(0), allowTap: challengeDays[selectedChallengeDayIndex].date == Calendar.current.startOfDay(for: Date())) {
                    DataStore.shared.saveChallengeDays(challengeDays)
                    }
            }
        }
    }
    
    private func challengeBinding(for index: Int) -> Binding<Challenge> {
        Binding(
            get: { self.challengeDays[selectedChallengeDayIndex].challenges[index] },
            set: { self.challengeDays[selectedChallengeDayIndex].challenges[index] = $0 }
        )
    }
}

#Preview {
    ChallengeGrid(challengeDays: Binding<[ChallengeDay]>(get: {
        return generateChallengeDays()
    }, set: { newValue in
    }), stepCounts: .constant(Array(repeating: 0, count: 75)), selectedChallengeDayIndex: .constant(1))
}
