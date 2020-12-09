//
//  Scheduler.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation
import Combine

// MARK: - Scheduler

final class Scheduler {
    
    // Background Work Scheduler
    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()
    
    // UI Work Scheduler
    static let mainScheduler = RunLoop.main
    
}
