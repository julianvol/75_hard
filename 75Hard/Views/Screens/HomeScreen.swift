//
//  HomeScreen.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI
import HealthKit

struct HomeScreen: View {
        
    @EnvironmentObject var dataStore: DataStore
    
    @State private var stepCounts: [Int] = Array(repeating: 0, count: 75)
    let healthStore = HealthStore()
    
    @State private var isDevSheetPresented: Bool = false
          
    var body: some View {
        ZStack {
            VStack {
                HomeViewHeader()
                    .padding(.top)
                
                DateElement()
                    .padding(.top, 20)
                ProgressBar()
                    .frame(height: 10)
                    .padding(.bottom)
                
                ChallengeTaskGrid(stepCount: $stepCounts[dataStore.selectedChallengeDayIndex])
                .padding(.top)
                
                Spacer()
                Button("Dev") {
                    isDevSheetPresented.toggle()
                }
            }
            .padding()
            .sheet(isPresented: $isDevSheetPresented, content: {
                DevSheet(onLoadDataLessButtonClickedAction: {
                    setData(offset: -5)
                }, onLoadDataBeginButtonClickedAction: {
                    setData(offset: 0)
                }, onLoadDataFewButtonClickedAction: {
                    setData(offset: 27)
                }, onLoadDataMiddleButtonClickedAction: {
                    setData(offset: 57)
                }, onLoadDataEndButtonClickedAction: {
                    setData(offset: 74)
                }, onLoadDataOverButtonClickedAction: {
                    setData(offset: 80)
                })
            })
            .onAppear {
                print("onAppear() -> HomeScreen")
                fetchStepCounts()
                startTimer()
            }
        }
    }
    
    private func startTimer() { // TODO use background delivery instead
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            fetchStepCounts()
        }
    }
    private func setData(offset: Int = 0) {
        dataStore.challenges[dataStore.selectedChallengeIndex].reset(withOffset: offset)
        dataStore.calculateIndices(forceCalculateSelectedChallengeDayIndex: true)
        fetchStepCounts()
        isDevSheetPresented = false
    }
    private func fetchStepCounts() {
        Task {
            healthStore.requestStepCountAuthorization()
            do {
                try await stepCounts = healthStore.fetchStepCounts(startDate: dataStore.challenges[dataStore.selectedChallengeIndex].challengeDays[0].date)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
