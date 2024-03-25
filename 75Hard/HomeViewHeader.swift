//
//  HomeViewHeader.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct HomeViewHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("75 Hard")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Strengthen your Body and Mind.")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
            Spacer()
            Image(uiImage: UIImage(systemName: "calendar.circle")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
        }
        .padding([.leading, .bottom, .trailing])
    }
}

#Preview {
    HomeViewHeader()
}
