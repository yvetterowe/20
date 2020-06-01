//
//  TimerWatchView.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct TimerWatchView: View {
    var model: Model
    struct Model {
        var textModel: Text.Model
        var radius: CGFloat
        var backgroundColorMode: BackgroundColorMode
    }
    
    var body: some View {
        Circle()
            .fill(model.backgroundColorMode)
            .overlay(Text(model.textModel.text).foregroundColor(model.textModel.textColor))
            .frame(width: model.radius * 2, height: model.radius * 2)
    }
}

struct TimerWatchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TimerWatchView(
                model: .init(
                    textModel: .init(text: "00:00", textColor: .white, textFont: .title),
                    radius: 30,
                    backgroundColorMode: .single(.gray)
                )
            )
            TimerWatchView(
                model: .init(
                    textModel: .init(text: "18:00", textColor: .white, textFont: .title),
                    radius: 86,
                    backgroundColorMode: .gradient(
                        .init(
                            gradient: .init(colors: [.blue,.green]),
                            startPoint: .init(x: 0.25, y: 0.5),
                            endPoint: .init(x: 0.75, y: 0.5)
                        )
                    )
                )
            )
        }
    }
}
