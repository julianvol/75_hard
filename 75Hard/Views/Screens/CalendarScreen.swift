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

            CalendarDaysGrid()
            
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
        dataStore.challenges[dataStore.selectedChallengeIndex].reset()
        dataStore.calculateIndices(forceCalculateSelectedChallengeDayIndex: true)
    }
    func onTapNavigateBackAction() {
        navigationState.changeScreen(to: .Home)
    }
}

#Preview {
    CalendarScreen()
}
