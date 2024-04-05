//
//  ChallengeElement.swift
//  75Hard
//
//  Created by Julian Müller on 03.04.24.
//

import SwiftUI

struct ChallengeElement: View {
    @Binding var challenge: Challenge

    var body: some View {
        HStack {
            Text(challenge.name)
            Spacer()
            if (challenge.isSelected) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.green)
            }
        }
        .contentShape(Rectangle()) // Ensure that the entire HStack is tappable
    }
}

