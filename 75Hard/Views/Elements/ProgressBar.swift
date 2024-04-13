//
//  ProgressBar.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct ProgressBar: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var lastSelectedTaskDayIndex: Int = 0
        
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {

                RoundedRectangle(cornerRadius: 12.5)
                    .foregroundColor(Color("progress_background"))
                    .frame(width: geometry.size.width, height: 26)
                
                RoundedRectangle(cornerRadius: 12.5)
                    .foregroundColor(Color("progress"))
                    .frame(width: 26+(min(CGFloat(max(min(dataStore.todaysChallengeDayIndex,74),0))/74.0, 1)*(geometry.size.width-26)), height: 26)
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color("selection"))//Color(red: 224/255.0, green: 161/255.0, blue: 79/255.0)
                    .frame(width: 16, height: 16)
                    .padding(.leading, 4.5+min(CGFloat(dataStore.selectedChallengeDayIndex)/74.0, 1) * (geometry.size.width-16-9))
                    .shadow(color: .black, radius: 3)
                
                Text(String(format: "%.0f%%", min(CGFloat(max(min(dataStore.todaysChallengeDayIndex,74),0)) / 74.0 * 100.0, 100.0)))
                    .font(.system(size: 13).bold())
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: dataStore.todaysChallengeDayIndex < 38 ? .trailing : .leading)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let stepWidth = (geometry.size.width-16-9)/(74/2)
                        let steps = Int(value.translation.width/stepWidth)
                        withAnimation {
                            if (value.translation.width > 0) {
                                dataStore.selectedChallengeDayIndex = min(lastSelectedTaskDayIndex+steps, dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays.count-1)
                            } else if (value.translation.width < 0) {
                                dataStore.selectedChallengeDayIndex = max(lastSelectedTaskDayIndex+steps, 0)
                            }
                        }
                    }
                    .onEnded { value in
                        lastSelectedTaskDayIndex = dataStore.selectedChallengeDayIndex
                        print(lastSelectedTaskDayIndex)
                    }
            )
            .onAppear {
                lastSelectedTaskDayIndex = dataStore.selectedChallengeDayIndex
            }
        }
    }
}

#Preview {
    ProgressBar()

}
