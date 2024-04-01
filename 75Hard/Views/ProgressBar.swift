//
//  ProgressBar.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct ProgressBar: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var todaysChallengeDayIndex: Int
    @Binding var selectedChallengeDayIndex: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 3)
                    .frame(width: geometry.size.width, height: 24)
                
                RoundedRectangle(cornerRadius: 11)
                    .foregroundColor(Color("progress"))//Color(red: 54/255.0, green: 106/255.0, blue: 179/255.0)
                    .frame(width: 22+(min(CGFloat(max(min(todaysChallengeDayIndex,74),0))/74.0, 1)*(geometry.size.width-22-2)), height: 22)
                    .padding(.leading, 1)
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color("selection"))//Color(red: 224/255.0, green: 161/255.0, blue: 79/255.0)
                    .frame(width: 16, height: 16)
                    .padding(.leading, 4+min(CGFloat(selectedChallengeDayIndex)/74.0, 1) * (geometry.size.width-16-8))
                    .shadow(color: .black, radius: 3)
                
                Text(String(format: "%.0f%%", min(CGFloat(max(min(todaysChallengeDayIndex,74),0)) / 74.0 * 100.0, 100.0)))
                    .font(.system(size: 13))
                    .padding(.horizontal, 7)
                    .frame(maxWidth: .infinity, alignment: todaysChallengeDayIndex < 38 ? .trailing : .leading)
            }
        }
    }
}

#Preview {
    ProgressBar(todaysChallengeDayIndex: Binding.constant(14), selectedChallengeDayIndex: Binding.constant(54))

}
