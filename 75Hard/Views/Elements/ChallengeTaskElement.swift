//
//  ChallengeTaskElement.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI


struct ChallengeTaskElement: View {

    @Binding var challengeTask: ChallengeTask
    @Binding var stepCount: Int

    @State private var scale: CGFloat = 1.0
    
    @State private var textColor: Color = .white
    @State private var isTouching: Bool = false
    @State private var hasTappedLongEnough: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    let allowTap: Bool
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(Color(challengeTask.isCompleted ? challengeTask.color : challengeTask.color_uncompleted))
            VStack {
                Image(systemName: challengeTask.imageName)
                    .resizable()
                    .foregroundColor(textColor)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 20)
                    .frame(width: 60, height: 60)
                Text((challengeTask.name == "Steps" ? "\(formatNumber(number: stepCount))/\(formatNumber(number: 10000))\n" : "") + challengeTask.name)
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
        .gesture(LongPressGesture(minimumDuration: 0.35, maximumDistance: 15)
            .onChanged { _ in
                if (!allowTap) {
                    return
                } else {
                    if (challengeTask.name == "Steps" && stepCount < 10000) {
                        self.textColor = Color("challenge_text_failed")
                    } else {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            self.scale = challengeTask.isCompleted ? 0.9 : 1.0
                        }
                        Timer.scheduledTimer(withTimeInterval: 0.35, repeats: false) { _ in
                            withAnimation(.easeInOut(duration: 0.35)) {
                                self.scale = challengeTask.isCompleted ? 1.0 : 0.9
                            }                        }
                    }
                }
            }
            .onEnded { _ in
                if (!allowTap) {
                    return
                } else {
                    let generator = UIImpactFeedbackGenerator(style: .rigid)
                    generator.impactOccurred()
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.challengeTask.isCompleted.toggle()
                        self.scale = challengeTask.isCompleted ? 1.0 : 0.9
                        self.textColor = challengeTask.isCompleted ? Color("challenge_text_completed") : Color("challenge_text_uncompleted")
                    }
                }
            }
        )
        .onAppear {
            if (challengeTask.isCompleted && challengeTask.name == "Steps" && stepCount < 10000) {
                challengeTask.isCompleted = false
            }
            self.textColor = challengeTask.isCompleted ? Color("challenge_text_completed") : Color("challenge_text_uncompleted")
            self.scale = challengeTask.isCompleted ? 1.0 : 0.9
        }
        .onChange(of: challengeTask) {
            withAnimation(.easeInOut(duration: 0.35)) {
                self.scale = challengeTask.isCompleted ? 1.0 : 0.9
            }
        }
    }

    
    func formatNumber(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "- - - -"
    }
}

#Preview {
    let dummyChallenge = ChallengeTask(name: "Random\ntask", imageName: "figure.run", color: "diet", color_uncompleted: "diet_uncompleted", isCompleted: true)
            let binding = Binding<ChallengeTask>(get: { dummyChallenge }, set: { _ in })

    return ChallengeTaskElement(challengeTask: binding, stepCount: .constant(9999), allowTap: true)
        .frame(width: 175, height: 100)
}
