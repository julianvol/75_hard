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
    @State private var hasTappedLongEnough: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    let allowTap: Bool
    let saveChanges: () -> Void // Closure to handle tap action
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(Color(challenge.isCompleted ? challenge.color : challenge.color_uncompleted))
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
        .cornerRadius(20.0)
        .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onChanged { _ in
                if (!allowTap || isTouching) {
                    return
                } else {
                    self.isTouching.toggle()
                    if (challenge.name == "Steps" && stepCount < 10000) {
                        self.textColor = Color("challenge_text_failed")
                    } else {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                            if (isTouching) { // send feedback
                                self.hasTappedLongEnough = true
                                let generator = UIImpactFeedbackGenerator(style: .rigid)
                                generator.impactOccurred()
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.challenge.isCompleted.toggle()
                                }
                            }
                        }
                        withAnimation(.easeInOut(duration: 0.25)) {
                            self.scale = 0.85
                        }
                    }
                }
            }
            .onEnded { _ in
                if (!allowTap || !isTouching) {
                    return
                } else {
                    self.isTouching.toggle()
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if (!(challenge.name == "Steps" && stepCount < 10000) && hasTappedLongEnough) {
                            self.hasTappedLongEnough = false
                            saveChanges()
                        }
                        self.scale = challenge.isCompleted ? 1.0 : 0.9
                        self.textColor = challenge.isCompleted ? Color("challenge_text_completed") : Color("challenge_text_uncompleted")
                    }
                }
            }
        )
        .onAppear {
            if (challenge.name == "Steps" && stepCount < 10000) {
                challenge.isCompleted = false
                saveChanges()
            }
            self.textColor = challenge.isCompleted ? Color("challenge_text_completed") : Color("challenge_text_uncompleted")
            self.scale = challenge.isCompleted ? 1.0 : 0.9
        }
    }

    
    func formatNumber(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "- - - -"
    }
}

#Preview {
    let dummyChallenge = Challenge(name: "Random\ntask", imageName: "figure.run", color: "diet", color_uncompleted: "diet_uncompleted", isCompleted: true)
            let binding = Binding<Challenge>(get: { dummyChallenge }, set: { _ in })

    return ChallengeElement(challenge: binding, stepCount: .constant(9999), allowTap: true, saveChanges: {})
        .frame(width: 175, height: 100)
}
