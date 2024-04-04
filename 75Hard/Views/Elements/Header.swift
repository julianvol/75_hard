//
//  HomeViewHeader.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct Header: View {
    @EnvironmentObject var navigationState: NavigationState
    @EnvironmentObject var dataStore: DataStore
         
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dataStore.selectedChallengeName)
                    .font(.title)
                    .fontWeight(.bold)
                Text(dataStore.selectedChallengePhrase)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Image(systemName: "calendar.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .foregroundColor(Color("sf"))
                .onTapGesture {
                    navigationState.changeScreen(to: .Calendar)
                }
        }
        .padding([.bottom, .trailing])
    }
}

#Preview {
    Header()
}
