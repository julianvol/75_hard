//
//  CalendarSheet.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import SwiftUI

struct CalendarSheet: View {
    @Binding var challengeDays: [ChallengeDay]
    @Binding var isCalendarSheetPresented: Bool
    @Binding var selectedChallengeDayIndex: Int
    @Binding var todaysChallengeDayIndex: Int
    let onTapResetAction: () -> Void
    
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

            daysGrid
            
            Spacer()
            
            HStack {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("sf"))
                    .onTapGesture{
                        onTapResetAction()
                    }
                
                Spacer()
                
                Image(systemName: "xmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("sf"))
                    .onTapGesture{
                        isCalendarSheetPresented = false
                    }
            }
            .padding([.leading, .trailing], 30)
            .padding(.bottom)

        }
    }
    private var daysGrid: some View {
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
                                .fontWeight(index <= todaysChallengeDayIndex ? .heavy : .regular)
                                .foregroundColor(index <= todaysChallengeDayIndex && challengeDays[index].allChallengesCompleted() ? .green :
                                                    index < todaysChallengeDayIndex && !challengeDays[index].allChallengesCompleted() ? .red : Color("sf"))
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(index < todaysChallengeDayIndex && challengeDays[index].allChallengesCompleted() ? .green :
                                        index < todaysChallengeDayIndex && !challengeDays[index].allChallengesCompleted() ? .red :
                                            index == todaysChallengeDayIndex ? Color("sf") : .clear,
                                        lineWidth: index == todaysChallengeDayIndex ? 3 : 1.5)	
                        }
                        
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        selectedChallengeDayIndex = index
                        isCalendarSheetPresented = false
                    }
            }
        }
        .padding([.leading, .bottom, .trailing], 25)
    }
}

#Preview {
    CalendarSheet(challengeDays: Binding.constant(generateChallengeDays()), isCalendarSheetPresented: .constant(false), selectedChallengeDayIndex: .constant(2), todaysChallengeDayIndex: .constant(3), onTapResetAction: {})
}
