//
//  TimeSpan.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import Foundation
import Combine

class TimeSpan: ObservableObject {
    @Published var value: TimeInterval
    
    var hours:  Int { return Int(value / 3600) }
    var minute: Int { return Int(value.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(value.truncatingRemainder(dividingBy: 60)) }
    
    var toDescription: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                   minute, second)
    }
    
    private var task: AnyCancellable? = nil
    private var startDate: Date = Date()
    
    
    init() {
        value = 0
    }
    
    private func createTimer() {
        task = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] currentDate in
                guard let self = self else {return}
                self.value = currentDate.timeIntervalSince1970 - self.startDate.timeIntervalSince1970
            }
    }
    
    func start() {
        startDate = Date()
        createTimer()
    }
    
    func pause() {
        task?.cancel()
    }
    
    func stop() {
        task?.cancel()
    }
    
    func resume() {
        startDate = Date().addingTimeInterval(-value)
        createTimer()
    }
}
