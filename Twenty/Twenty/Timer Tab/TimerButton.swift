//
//  TimerButton.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct TimerButton: View {
    var model: ButtonModel
    
    var body: some View {
        Button(action: {
            // TODO: handle button action
        }) { Text(model.textModel.text) }
        .padding()
        .border(model.border)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: model.cornerRadius, style: .continuous)
                    .fill(model.backgroundColorMode)
            }
        )
        .foregroundColor(model.textModel.textColor)
    }
}

struct TimerButton_Previews: PreviewProvider {
    static var previews: some View {
        TimerButton(
            model: .init(
                textModel: .init(text: "hello", textColor: .blue, textFont: .title),
                backgroundColorMode: .single(.pink)
            )
        )
    }
}
