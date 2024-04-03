//
//  SplashScreen.swift
//  75Hard
//
//  Created by Julian Müller on 01.04.24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var scale = 0.7
    @State private var opacity = 0.6

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if (isActive) {
            StepDataConsent()
        } else {
            VStack {
                VStack {
                    Spacer()
                    Image(colorScheme == .light ? "AppSplash" : "AppSplash_dark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        self.scale = 1.0
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.opacity = 0.0
                        }
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
