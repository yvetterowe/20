//
//  TimeLabelComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct TimeLabelComponent: View {
    let duration: TimeInterval
    
    var body: some View {
        Text("\(duration.format())")
    }
}

private extension TimeInterval {
    func format() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%ih %im %is", hours, minutes, seconds)
    }
}

struct TimeLabelComponent_Previews: PreviewProvider {
    static var previews: some View {
        TimeLabelComponent(duration: 3650)
    }
}
