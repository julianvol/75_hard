//
//  ContentView.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct ContentView: View {
    let data = TaskList
    
    var body: some View {
        VStack {
            HomeViewHeader()
                .padding(.vertical)
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 15),  GridItem(.flexible())], spacing: 15) {
                ForEach(data, id: \.self) { task in
                   TaskElement(task: task)
                }
            }
            .padding(.bottom)
            ProgressBar(progress: 0.4)
                .padding(.top)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
