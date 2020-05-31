//
//  DateHelpers.swift
//  Twenty
//
//  Created by Hao Luo on 5/31/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

extension Date {

    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }

}
