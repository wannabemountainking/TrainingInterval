//
//  IntervalViewModel.swift
//  TrainingInterval
//
//  Created by yoonie on 4/12/26.
//

import Foundation
import Combine
import Observation


final class IntervalViewModel: ObservableObject {
    
    // MARK: - Properties: publisher, connection, cancellables, 현재 시간, 남은 시간, phase, progress
    let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
    var cancellables: Set<AnyCancellable>
    var connection: Cancellable?
    
    @Published var currentSecond: Int
    @Published var phase: ExerciseMode
    var timeLeft: Int {
        self.phase.totalTime - self.currentSecond
    }
    var progressBar: Int {
        Int(self.currentSecond * 10 / self.phase.totalTime)
    }
    
    init(cancellables: Set<AnyCancellable> = Set<AnyCancellable>(), connection: Cancellable? = nil, currentSecond: Int = 0, phase: ExerciseMode = .trainingMode) {
        self.cancellables = cancellables
        self.connection = connection
        self.currentSecond = currentSecond
        self.phase = phase
    }
    
    func start() {
        timerPublisher
            .scan(0) { prev, _ in
                prev + 1
            }
            .sink { [weak self] seconds in
                guard let self else {return}
                self.currentSecond += 1
                print(self.currentSecond)
                if self.currentSecond > self.phase.totalTime {
                    self.phase = (self.phase == .trainingMode) ? .relaxMode : .trainingMode
                    self.currentSecond = 0
                }
            }
            .store(in: &cancellables)
        connection = timerPublisher.connect()
    }
    
    func stop() {
        connection?.cancel()
        connection = nil
        cancellables.removeAll()
    }
    
    func resume() {
        cancellables.removeAll()
        start()
        connection = timerPublisher.connect()
    }
    
    func reset() {
        stop()
        cancellables.removeAll()
        self.currentSecond = 0
        self.phase = .trainingMode
    }
    
}


