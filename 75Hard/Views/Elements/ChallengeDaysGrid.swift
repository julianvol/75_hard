//
//  ChallengeDaysGrid.swift
//  75Hard
//
//  Created by Julian Müller on 04.04.24.
//

import SwiftUI

struct ChallengeDaysGrid: View {

    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var dataStore: DataStore

    //@Binding var challengeDays: [ChallengeDay]
    //@Binding var todaysChallengeDayIndex: Int
    //@Binding var selectedChallengeDayIndex: Int
    
    // var onTap: () -> Void
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible())
        ], spacing: 5) {
            ForEach(0..<75, id: \.self) { index in
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.clear)
                    .overlay(
                        ZStack {
                            Text("\(index + 1)")
                                .fontWeight(index <= dataStore.todaysChallengeDayIndex ? .heavy : .regular)
                                .foregroundColor(index <= dataStore.todaysChallengeDayIndex && dataStore.isDayComplete(index: index) ? .green :
                                                    index < dataStore.todaysChallengeDayIndex && !dataStore.isDayComplete(index: index) ? .red : Color("sf"))
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(index < dataStore.todaysChallengeDayIndex && dataStore.isDayComplete(index: index) ? .green :
                                            index < dataStore.todaysChallengeDayIndex && !dataStore.isDayComplete(index: index) ? .red :
                                            index == dataStore.todaysChallengeDayIndex ? Color("sf") : .clear,
                                        lineWidth: index == dataStore.todaysChallengeDayIndex ? 3 : 1.5)
                        }
                        
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        dataStore.selectedChallengeDayIndex = index
                        print(dataStore.selectedChallengeDayIndex)
                        navigationState.changeScreen(to: .Home)
                    }
            }
        }
        .padding([.leading, .bottom, .trailing], 25)
    }
}

#Preview {
    ChallengeDaysGrid()
}
