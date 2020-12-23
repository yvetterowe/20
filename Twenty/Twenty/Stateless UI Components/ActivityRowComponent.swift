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
                .font(Font.custom("VarelaRound-Regular", size: 18))
                .foregroundColor(ColorManager.MidGray)
            
            Spacer()
            Text(recordTime.start.formatString())
                .font(Font.custom("VarelaRound-Regular", size: 18))
                .foregroundColor(ColorManager.MidGray)
            
        }
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}

private extension Date {
    func formatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat="MMM dd HH:mm"
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
