//
//  ChallengeElement.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct ChallengeElement: View {

    @Binding var challenge: Challenge
    @Binding var stepCount: Int
    
    @State private var scale: CGFloat = 1.0
    @State private var textColor: Color = .white
    @State private var isTouching: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    let allowTap: Bool
    let saveChanges: () -> Void // Closure to handle tap action
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(Color(challenge.isCompleted ? challenge.color : challenge.color_uncompleted))
                //.opacity(challenge.isCompleted ? 0.9 : colorScheme == .light ? 0.1 : 0.3)
            VStack {
                Image(systemName: challenge.imageName)
                    .resizable()
                    .foregroundColor(textColor)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 20)
                    .frame(width: 60, height: 60)
                Text((challenge.name == "Steps" ? "\(formatNumber(number: stepCount))/\(formatNumber(number: 10000))\n" : "") + challenge.name)
                    .foregroundColor(textColor)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scaleEffect(scale)
        //.background(.white)
        .cornerRadius(20.0)
        .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onChanged { _ in
                if (!allowTap || isTouching) {
                    return
                } else {
                    self.isTouching.toggle()
                    if (challenge.name == "Steps" && stepCount < 10000) {
                        self.textColor = Color("failed")
                    }
                    withAnimation() {
                        self.scale = 0.95
                    }
                }
            }
            .onEnded { _ in
                if (!allowTap || !isTouching) {
                    return
                } else {
                    self.isTouching.toggle()
                    withAnimation() {
                        if (!(challenge.name == "Steps" && stepCount < 10000)) {
                            self.challenge.isCompleted.toggle()
                            saveChanges()
                        }
                        self.scale = 1.0
                        self.textColor = challenge.isCompleted ? .white : .black
                    }
                }
            }
        )
        .onAppear {
            self.textColor = challenge.isCompleted ? .white : .black
        }
    }

    
    func formatNumber(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
//        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number)) ?? "- - - -"
    }
}

#Preview {
    let dummyChallenge = Challenge(name: "Steps", imageName: "figure.run", color: "diet", color_uncompleted: "diet_uncompleted", isCompleted: true)
            // Create a Binding to the dummy challenge
            let binding = Binding<Challenge>(get: { dummyChallenge }, set: { _ in })

            // Preview the ChallengeElement with the binding
    return ChallengeElement(challenge: binding, stepCount: .constant(9999), allowTap: true, saveChanges: {})
//                .previewLayout(.sizeThatFits)
                .padding()
}
