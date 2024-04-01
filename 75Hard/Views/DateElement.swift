//
//  DateElement.swift
//  75Hard
//
//  Created by Julian Müller on 26.03.24.
//

import SwiftUI

struct DateElement: View {
    @Binding var date: Date
    @Binding var selectedChallengeDayIndex: Int
    var body: some View {
        HStack {
            Text("Day " + String(selectedChallengeDayIndex + 1))
            Spacer()
            Text(formatDate(date: date))
        }
        .font(.subheadline)
    }
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}

//let comparisonDate = Date.now
//#Preview {
//    DateElement(date: Binding.constant(Date()), detailChallengeDayIndex: Binding.constant(0))
//}
