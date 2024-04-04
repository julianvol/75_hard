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

    //@State private var challenges: [ChallengeConstruct] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(dataStore.challengeConstructs.indices, id: \.self) { index in
                    ChallengeConstructElement(challenge: $dataStore.challengeConstructs[index])
                        .onTapGesture {
                            if (!dataStore.challengeConstructs[index].isSelected) {
                                selectChallenge(at: index)
                                dataStore.saveChallengeConstructs()
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
            dataStore.loadChallengeConstructs()
        }
    }
    private func selectChallenge(at index: Int) {
        // Deselect all challenges
        for i in dataStore.challengeConstructs.indices {
            dataStore.challengeConstructs[i].isSelected = false
        }
        // Select the tapped challenge
        dataStore.challengeConstructs[index].isSelected = true
        // recalculate indices for screens
        dataStore.calculateIndices(forceCalculateSelectedChallengeDayIndex: true)
    }
}

#Preview {
    SelectChallengesScreen()
}
