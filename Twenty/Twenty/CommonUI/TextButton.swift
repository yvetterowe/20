//
//  TextButton.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct TextButton: View {
    var model: ButtonModel
    
    var body: some View {
        Button(action: model.action) { Text(model.textModel.text) }
        .padding()
        .border(model.border)
        .background(model.backgroundShape, model.backgroundColorMode)
        .foregroundColor(model.textModel.textColor)
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextButton(
                model: .init(
                    textModel: .init(text: "hello", textColor: .blue, textFont: .title),
                    backgroundColorMode: .single(.pink),
                    backgroundShape: .roundedRectangle(cornerRadius: 24),
                    action: {}
                )
            )
            TextButton(
                model: .init(
                    textModel: .init(text: "hello", textColor: .black, textFont: .title),
                    backgroundColorMode: .single(.blue),
                    backgroundShape: .circle(radius: 8),
                    action: {}
                )
            )
        }
    }
}
