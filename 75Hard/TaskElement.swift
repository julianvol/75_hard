//
//  TaskElement.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI

struct TaskElement: View {

    let task: Task

    var body: some View {
        VStack {
            Image(uiImage: UIImage(systemName: task.imageName)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 20)
                .frame(width: 60, height: 60)
            Text(task.name)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(height: 50)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .cornerRadius(40)
    }
}

#Preview {
    TaskElement(task: TaskList[0])
}
