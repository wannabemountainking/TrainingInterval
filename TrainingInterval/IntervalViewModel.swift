//
//  IntervalViewModel.swift
//  TrainingInterval
//
//  Created by yoonie on 4/12/26.
//

import Foundation
import Combine
import Observation

@Observable
final class IntervalViewModel {
    
    // MARK: - Properties: publisher, connection, cancellables, 현재 시간, 남은 시간, phase, progress
    let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
    let cancellables = Set<AnyCancellable>()
    var connection: Cancellable?
    
    var currentSecond: Int
    var phase: ExerciseMode
    var timeLeft: Int {
        switch phase {
        case .trainingMode(let totalTime), .relaxMode(let totalTime):
            return totalTime - currentSecond
        }
    }
    var progressBar: Int {
        switch phase {
        case .trainingMode(let totalTime), .relaxMode(let totalTime):
            return currentSecond / totalTime
        }
    }
    
    init(connection: Cancellable? = nil, currentSecond: Int, phase: ExerciseMode) {
        self.connection = connection
        self.currentSecond = currentSecond
        self.phase = phase
    }
    
    func runTimer() {

    }
}

