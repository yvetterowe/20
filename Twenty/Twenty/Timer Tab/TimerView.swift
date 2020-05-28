//
//  TimerView.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    var model: Model
    struct Model {
        var textModel: Text.Model
        var radius: CGFloat
        var backgroundColorMode: BackgroundColorMode
        
        enum BackgroundColorMode {
            case single(Color)
            case gradient(LinearGradient)
        }
    }
    
    private var filledCircle: some View {
        switch model.backgroundColorMode {
        case let .single(color):
            return AnyView(Circle().fill(color))
        case let .gradient(gradient):
            return AnyView(Circle().fill(gradient))
        }
    }
    
    var body: some View {
        self.filledCircle
            .overlay(Text(model.textModel.text).foregroundColor(model.textModel.textColor))
            .frame(width: model.radius * 2, height: model.radius * 2)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TimerView(
                model: .init(
                    textModel: .init(text: "00:00", textColor: .white, textFont: .title),
                    radius: 30,
                    backgroundColorMode: .single(.gray)
                )
            )
            TimerView(
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
