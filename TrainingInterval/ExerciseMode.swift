//
//  TrainingPhase.swift
//  TrainingInterval
//
//  Created by yoonie on 4/12/26.
//

import Foundation


enum ExerciseMode {
    case trainingMode
    case relaxMode
    
    var totalTime: Int {
        switch self {
        case .trainingMode: return 30
        case .relaxMode: return 10
        }
    }
}
