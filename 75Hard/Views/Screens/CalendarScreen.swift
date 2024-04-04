//
//  CalendarScreen.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import SwiftUI

struct CalendarScreen: View {
    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var dataStore: DataStore

    //@State var challengeConstructs: [ChallengeConstruct] = generateChallengeConstructList() // TODO, list with loading placeholders
    //@State var selectedChallengeIndex: Int = 0
    //@State var selectedChallengeDayIndex: Int = 0
    //@State var todaysChallengeDayIndex: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Calendar")
                    .font(.title)
                    .fontWeight(.bold)
                .padding(.top)
                Spacer()
            }
            .padding(.horizontal)

            DaysGrid()
            
            Spacer()
            
            HStack {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("sf"))
                    .onTapGesture{
                        onTapResetAction()
                        onTapNavigateBackAction()
                    }
                
                Spacer()
                
                Text("select")
                    .onTapGesture {
                        navigationState.changeScreen(to: .Select)
                    }
                
                Spacer()
                
                Image(systemName: "xmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("sf"))
                    .onTapGesture{
                        onTapNavigateBackAction()
                    }
            }
            .padding([.leading, .trailing], 30)
            .padding(.bottom)

        }
        .onAppear {
            print("onApper() -> CalendarScreen")
        }
    }
        
    func onTapResetAction() {
        //setData()
        dataStore.challengeConstructs[dataStore.selectedChallengeIndex].reset()
        dataStore.saveChallengeConstructs()
        dataStore.calculateIndices(forceCalculateSelectedChallengeDayIndex: true)
    }
    func onTapNavigateBackAction() {
        navigationState.changeScreen(to: .Home)
    }
    
    private func getData() {
        // challengeConstructs = DataStore.shared.loadChallengeConstructs()
        dataStore.loadChallengeConstructs()
        dataStore.calculateIndices()
    }
    private func setData(offset: Int = 0) {
        // TODO fix, that the challengeDays are resetet to the right ChallengeDayList
        dataStore.challengeConstructs[dataStore.selectedChallengeIndex].challengeDays = generateChallengeDayList(offset: offset)
        dataStore.saveChallengeConstructs()
        dataStore.calculateIndices()
    }
}

#Preview {
    CalendarScreen()
}
