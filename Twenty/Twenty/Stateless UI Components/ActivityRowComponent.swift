//
//  ActivityRowComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ActivityRowComponent: View {
    let recordTime: DateInterval
    
    var body: some View {
        HStack {
            Text(recordTime.duration.format(showSecond: false))
            Spacer()
            Text(recordTime.start.formatString())
        }
    }
}

private extension Date {
    func formatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}

struct ActivityRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRowComponent(
            recordTime: .init(
                start: Date(),
                duration: 3800
            )
        )
    }
}
