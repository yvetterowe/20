//
//  ButtonModel.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ButtonModel {
    let textModel: Text.Model
    let backgroundColorMode: BackgroundColorMode
    let cornerRadius: CGFloat
    let border: BorderMode
        
    init(
        textModel: Text.Model,
        backgroundColorMode: BackgroundColorMode,
        cornerRadius: CGFloat = 24,
        border: BorderMode = .none
    ) {
        self.textModel = textModel
        self.backgroundColorMode = backgroundColorMode
        self.cornerRadius = cornerRadius
        self.border = border
    }
}
