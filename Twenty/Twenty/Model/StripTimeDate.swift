//
//  StripTimeDate.swift
//  Twenty
//
//  Created by Hao Luo on 5/31/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

// A Date wrapper that stripes time information (aka. hour, month, minute)
struct StripTimeDate: Hashable {
    private let stripTimeDate: Date
    
    init(_ stripTimeDate: Date) {
        precondition(stripTimeDate.hasStripTime, "\(stripTimeDate) doesn't strip time!")
        self.stripTimeDate = stripTimeDate
    }
}

extension Date {
    
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
    
    var hasStripTime: Bool {
        let calendar = Calendar.current
        
        return calendar.component(.hour, from: self) == 0 &&
            calendar.component(.minute, from: self) == 0 &&
            calendar.component(.second, from: self) == 0
    }

}
