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
    var trainingMode: ExerciseMode = .trainingMode
    var trainingProgress: Int = 0
    var relaxingProgress: Int = 0
    
    var timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
    var timeLeft: Date = Date()
    var timerConnection: Cancellable?
    
    
    init(trainingMode: ExerciseMode, trainingProgress: Int, relaxingProgress: Int, timerPublisher: Timer.TimerPublisher = Timer.publish(every: 1.0, on: .main, in: .common), timeLeft: Date, timerConnection: AnyCancellable? = nil) {
        self.trainingMode = trainingMode
        self.trainingProgress = trainingProgress
        self.relaxingProgress = relaxingProgress
        self.timerPublisher = timerPublisher
        self.timeLeft = timeLeft
        self.timerConnection = timerConnection
    }
    
    func start() {
        timerConnection = timerPublisher.connect()
    }
    
    func stop() {
        guard timerConnection != nil else { return }
        timerConnection?.cancel()
        timerConnection = nil
    }
    
    func resume() {
        
    }
}

