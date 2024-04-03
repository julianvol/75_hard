//
//  ContentView.swift
//  75Hard
//
//  Created by Julian Müller on 25.03.24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
        
    @State private var selectedChallengeDayIndex: Int = 0
    @State private var todaysChallengeDayIndex: Int = 0
    @State private var challengeDays: [ChallengeDay] = generateChallengeDays()
    @State private var stepCounts: [Int] = []
    @State private var isCalendarSheetPresented = false
    @State private var isDevSheetPresented = false
    @State private var isPressing = false
    let healthStore = HealthStore()
        
    var body: some View {
        ZStack {
            Color(Color("background"))
                .ignoresSafeArea()
            VStack {
                Header(onTapCalendarAction: {
                    isCalendarSheetPresented.toggle()
                })
                .padding(.top)
                
                DateElement(date: $challengeDays[selectedChallengeDayIndex].date, selectedChallengeDayIndex: $selectedChallengeDayIndex)
                    .padding(.top, 20)
                ProgressBar(todaysChallengeDayIndex:  $todaysChallengeDayIndex, selectedChallengeDayIndex: $selectedChallengeDayIndex)
                    .frame(height: 10)
                    .padding(.bottom)
                
                ChallengeGrid(challengeDays: $challengeDays, stepCounts: $stepCounts, selectedChallengeDayIndex: $selectedChallengeDayIndex)
                    .padding(.top)
                
                Spacer()
                Button("Dev") {
                    isDevSheetPresented.toggle()
                }
            }
            .padding()
            .sheet(isPresented: $isCalendarSheetPresented, onDismiss: {}, content: {
                CalendarSheet(challengeDays: $challengeDays, isCalendarSheetPresented: $isCalendarSheetPresented, selectedChallengeDayIndex: $selectedChallengeDayIndex, todaysChallengeDayIndex: $todaysChallengeDayIndex, onTapResetAction: {
                    setData()
                    isCalendarSheetPresented.toggle()
                })
            })
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
  
    func calculateTodaysChallengeDayIndex() -> Int {
        let todaysChallengeDay = Calendar.current.startOfDay(for: Date.now)
        for challengeIndex in 0..<challengeDays.count {
            let tmpChallengeDay = Calendar.current.startOfDay(for: challengeDays[challengeIndex].date)
            if (tmpChallengeDay > todaysChallengeDay) { // start day lays in the furture
                return -1
            } else if (tmpChallengeDay == todaysChallengeDay) { // found todays day
                return challengeIndex
            }
        }
        return 75 // last day lays in the past
    }
    
    private func calculateIndices() {
        todaysChallengeDayIndex = calculateTodaysChallengeDayIndex()
        selectedChallengeDayIndex = max(min(calculateTodaysChallengeDayIndex(),74),0) // selectedIndex has to be in [0...74]
    }
    
    private func getData() {
        challengeDays = DataStore.shared.loadChallengeDays()
        calculateIndices()
        fetchStepCounts()
    }
    private func setData(offset: Int = 0) {
        challengeDays = generateChallengeDays(offset: offset)
        DataStore.shared.saveChallengeDays(challengeDays)
        calculateIndices()
        fetchStepCounts()
    }
    private func fetchStepCounts() {
        Task {
            healthStore.requestStepCountAuthorization()
            do {
                try await stepCounts = healthStore.fetchStepCounts(startDate: challengeDays[0].date)
            } catch {
                print(error)
            }
            print(stepCounts)
        }
    }
}

#Preview {
    ContentView()
}
