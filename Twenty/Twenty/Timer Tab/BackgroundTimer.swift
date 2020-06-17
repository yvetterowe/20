//
//  BackgroundTimer.swift
//  Twenty
//
//  Created by Hao Luo on 5/29/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

final class BackgroundTimer {
    
    private var state: State = .suspended
    private enum State {
        case suspended
        case resumed
    }

    private let timeInterval: TimeInterval
    private let eventHandler: (_ tickInterval: TimeInterval) -> Void
    
    init(timeInterval: TimeInterval, eventHandler: @escaping (_ tickInterval: TimeInterval) -> Void) {
        self.timeInterval = timeInterval
        self.eventHandler = eventHandler
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now() + self.timeInterval, repeating: self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
            guard let self = self else {
                return
            }
            
            self.eventHandler(self.timeInterval)
        })
        return t
    }()

    deinit {
        timer.setEventHandler {}
        timer.cancel()
        resume()
    }

    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }
}
