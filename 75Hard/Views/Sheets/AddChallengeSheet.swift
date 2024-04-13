//
//  AddChallengeSheet.swift
//  75Hard
//
//  Created by Julian Müller on 09.04.24.
//

import SwiftUI

struct AddChallengeSheet: View {
    
    @State private var challenge: Challenge = Challenge(name: "", phrase: "", challengeDays: generatePlaceholderChallengeDayList(), isWeelkyChallenge: false, isSelected: false)
    // TODO: create real Template Challenge!
    
    var onSave: (Challenge) -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack {
            Text("Edit Challenges Sheet!")
            TextField("name", text: $challenge.name)
            TextField("phrase", text: $challenge.phrase)
            HStack {
                Button("Back") {
                    onCancel()
                }
            }
            Button("Save") {
                onSave(challenge)
            }
        }
        .padding()
        .onChange(of: challenge) {
            print(challenge)
        }
    }
}

#Preview {
    let SampleChallenge: Challenge = .init(name: "", phrase: "", challengeDays: [], isWeelkyChallenge: false, isSelected: false)
    
    return EditChallengeSheet(challenge: .constant(SampleChallenge), onSave: {}, onCancel: {})
}
