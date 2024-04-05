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

    @State private var isShowingConfirmation = false
    //@State var challenges: [Challenge] = generateChallengeList() // TODO, list with loading placeholders
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

            ChallengeDaysGrid()
            
            Spacer()
            
            HStack {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("sf"))
                    .onTapGesture{
                        isShowingConfirmation = true
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
        .alert(isPresented: $isShowingConfirmation) {
            Alert(
                title: Text("Reset Progress"),
                message: Text("Are you sure you want to reset your Progress? This Action cannot be reversed!"),
                primaryButton: .destructive(Text("Yes")) {
                    onTapResetAction()
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            print("onApper() -> CalendarScreen")
        }
    }
        
    func onTapResetAction() {
        //setData()
        dataStore.challenges[dataStore.selectedChallengeIndex].reset()
        dataStore.saveChallenges()
        dataStore.calculateIndices(forceCalculateSelectedChallengeDayIndex: true)
    }
    func onTapNavigateBackAction() {
        navigationState.changeScreen(to: .Home)
    }
    
    private func getData() {
        // challenges = DataStore.shared.loadChallenges()
        dataStore.loadChallenges()
        dataStore.calculateIndices()
    }
    private func setData(offset: Int = 0) {
        // TODO fix, that the challengeDays are resetet to the right ChallengeDayList
        dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays = generateChallengeDayList(offset: offset)
        dataStore.saveChallenges()
        dataStore.calculateIndices()
    }
}

#Preview {
    CalendarScreen()
}
