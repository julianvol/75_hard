//
//  ProgressBar.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 20)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle()
                    .frame(width: min(progress * geometry.size.width, geometry.size.width), height: 20)
                    .foregroundColor(Color.green)
                
                Text("\(Int(progress * 100))%")
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 4)
            }
            .cornerRadius(10)
        }
    }
}

#Preview {
    ProgressBar(progress: 0.4)

}
