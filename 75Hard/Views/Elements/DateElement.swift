//
//  DateElement.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import SwiftUI

struct DateElement: View {
    
    @EnvironmentObject var dataStore: DataStore

    var body: some View {
        HStack {
            Text("Day " + String(dataStore.selectedChallengeDayIndex + 1))
            Spacer()
            Text(formatDate(date: dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[dataStore.selectedChallengeDayIndex].date))
        }
        .font(.subheadline)
    }
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}

let comparisonDate = Date.now
#Preview {
    DateElement()
}
