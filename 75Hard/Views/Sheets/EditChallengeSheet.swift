//
//  EditChallengesSheet.swift
//  75Hard
//
//  Created by Julian Müller on 03.04.24.
//

import SwiftUI

struct EditChallengeSheet: View {
        
    @Binding var challenge: Challenge
    
    var onSave: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack {
            Text("Edit Challenges Sheet!")
            TextField("name", text: $challenge.name)
            Button("Back") {
                onCancel()
            }
        }
        .onChange(of: challenge) {
            print(challenge.name)
        }
    }
}

#Preview {
    var SampleChallenge: Challenge = .init(name: "", phrase: "", challengeDays: [], isWeelkyChallenge: false, isSelected: false)
    
    return EditChallengeSheet(challenge: .constant(SampleChallenge), onSave: {}, onCancel: {})
    return EditChallengeSheet(challenge: .constant(SampleChallenge), onSave: {}, onCancel: {})
}
