//
//  DevSheet.swift
//  75Hard
//
//  Created by Julian Müller on 29.03.24.
//

import SwiftUI

struct DevSheet: View {
    let onLoadDataLessButtonClickedAction: () -> Void
    let onLoadDataBeginButtonClickedAction: () -> Void
    let onLoadDataFewButtonClickedAction: () -> Void
    let onLoadDataMiddleButtonClickedAction: () -> Void
    let onLoadDataEndButtonClickedAction: () -> Void
    let onLoadDataOverButtonClickedAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Load Data")
                .font(.title)
            Button("Less") {
                onLoadDataLessButtonClickedAction()
            }.padding()
            Button("Begin") {
                onLoadDataBeginButtonClickedAction()
            }.padding()
            Button("Few") {
                onLoadDataFewButtonClickedAction()
            }.padding()
            Button("Middle") {
                onLoadDataMiddleButtonClickedAction()
            }.padding()
            Button("End") {
                onLoadDataEndButtonClickedAction()
            }.padding()
            Button("Over") {
                onLoadDataOverButtonClickedAction()
            }.padding()
        }
    }
}

#Preview {
    DevSheet(onLoadDataLessButtonClickedAction: {}, onLoadDataBeginButtonClickedAction: {}, onLoadDataFewButtonClickedAction: {}, onLoadDataMiddleButtonClickedAction: {}, onLoadDataEndButtonClickedAction: {}, onLoadDataOverButtonClickedAction: {})
}
