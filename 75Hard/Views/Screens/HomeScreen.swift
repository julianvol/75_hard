//
//  HomeScreen.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI
import HealthKit

struct HomeScreen: View {
        
    //@State private var selectedChallengeIndex: Int = 0
    //@State private var selectedChallengeDayIndex: Int = 0
    //@State private var todaysChallengeDayIndex: Int = 0
    
    @EnvironmentObject var dataStore: DataStore
    
    @State private var stepCounts: [Int] = []
    let healthStore = HealthStore()
    
    @State private var isDevSheetPresented: Bool = false
          
    var body: some View {
        ZStack {
            VStack {
                Header()
                    .padding(.top)
                
                DateElement()
                    .padding(.top, 20)
                ProgressBar()
                    .frame(height: 10)
                    .padding(.bottom)
                
                ChallengeGrid(stepCounts: $stepCounts)
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
                print("onAppear() -> HomeScreen \(dataStore.selectedChallengeDayIndex)")
                getData()
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
    
    private func getData() {
        dataStore.loadChallengeConstructs()
        dataStore.calculateIndices()
        fetchStepCounts()
    }
    private func setData(offset: Int = 0) {
        // TODO fix, that the challengeDays are resetet to the right ChallengeDayList
        dataStore.challengeConstructs[dataStore.selectedChallengeIndex].reset(withOffset: offset)
        //DataStore.shared.saveChallengeConstructs(challengeConstructs)
        dataStore.saveChallengeConstructs()
        dataStore.calculateIndices(forceCalculateSelectedChallengeDayIndex: true)
        fetchStepCounts()
        isDevSheetPresented = false
    }
    private func fetchStepCounts() {
        Task {
            healthStore.requestStepCountAuthorization()
            do {
                try await stepCounts = healthStore.fetchStepCounts(startDate: dataStore.challengeConstructs[dataStore.selectedChallengeIndex].challengeDays[0].date)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
