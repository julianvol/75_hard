//
//  CalendarDaysGrid.swift
//  75Hard
//
//  Created by Julian Müller on 04.04.24.
//

import SwiftUI

struct CalendarDaysGrid: View {

    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var dataStore: DataStore

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
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(index < dataStore.todaysChallengeDayIndex && dataStore.isDayComplete(index: index) ? .green :
                                            index < dataStore.todaysChallengeDayIndex && !dataStore.isDayComplete(index: index) ? .red :
                                            index == dataStore.todaysChallengeDayIndex ? Color("sf") : .clear,
                                        lineWidth: index == dataStore.todaysChallengeDayIndex ? 3 : 1.5)
                            Text("\(index + 1)")
                                .fontWeight(index <= dataStore.todaysChallengeDayIndex ? .heavy : .regular)
                                .foregroundColor(index <= dataStore.todaysChallengeDayIndex && dataStore.isDayComplete(index: index) ? .green :
                                                    index < dataStore.todaysChallengeDayIndex && !dataStore.isDayComplete(index: index) ? .red : Color("sf"))
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
    CalendarDaysGrid()
}
