//
//  AddTimeComponent.swift
//  Twenty
//
//  Created by Hao Luo on 12/15/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct AddTimeComponent: View {
    let dateInterval: DateInterval
    let editStartTimeAction: () -> Void
    let editEndTimeAction: () -> Void
    
    var body: some View {
        VStack {
            TimeLabelComponent(duration: 0).padding()
            List {
                EditTimeRowComponent(
                    title: "Start at",
                    buttonTitle: dateInterval.start.timeFormat(),
                    buttonAction: editStartTimeAction
                )
                EditTimeRowComponent(
                    title: "End at",
                    buttonTitle: dateInterval.end.timeFormat(),
                    buttonAction: editEndTimeAction
                )
            }
        }
    }
}

struct AddTimeComponent_Previews: PreviewProvider {
    static var previews: some View {
        AddTimeComponent(dateInterval: .init(), editStartTimeAction: {}, editEndTimeAction: {})
    }
}
