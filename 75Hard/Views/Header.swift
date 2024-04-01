//
//  HomeViewHeader.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct Header: View {
    let onTapCalendarAction: () -> Void
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("75 Hard")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Strengthen your Body and Mind.")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Spacer()
            Image(systemName: "calendar.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color("sf"))
                            .onTapGesture{
                                onTapCalendarAction()
                            }
        }
        .padding([.bottom, .trailing])
    }
}

#Preview {
    Header(onTapCalendarAction: {})
}
