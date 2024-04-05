//
//  SelectChallengesScreen.swift
//  75Hard
//
//  Created by Julian Müller on 03.04.24.
//

import SwiftUI


struct SelectChallengesScreen: View {
    
    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        VStack {
            List {
                ForEach(dataStore.challenges.indices, id: \.self) { index in
                    ChallengeElement(challenge: $dataStore.challenges[index])
                        .onTapGesture {
                            if (!dataStore.challenges[index].isSelected) {
                                selectChallenge(at: index)
                            }
                        }
                }
            }
            Text("Back")
                .onTapGesture {
                    withAnimation {
                        navigationState.changeScreen(to: .Calendar)
                    }
            }
        }
        .onAppear {
            print("onAppear() -> SelectScreen")
        }
    }
    private func selectChallenge(at index: Int) {
        // Deselect all challenges
        for i in dataStore.challenges.indices {
            dataStore.challenges[i].isSelected = false
        }
        // Select the tapped challenge
        dataStore.challenges[index].isSelected = true
        // recalculate indices for screens
        dataStore.calculateIndices(forceCalculateSelectedChallengeDayIndex: true)
    }
}

#Preview {
    SelectChallengesScreen()
}
