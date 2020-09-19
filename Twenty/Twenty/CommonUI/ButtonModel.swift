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
    let backgroundShape: BackgroundShape
    let border: BorderMode
    let action: () -> Void
        
    init(
        textModel: Text.Model,
        backgroundColorMode: BackgroundColorMode,
        backgroundShape: BackgroundShape = .roundedRectangle(cornerRadius: 24),
        border: BorderMode = .none,
        action: @escaping () -> Void
    ) {
        self.textModel = textModel
        self.backgroundColorMode = backgroundColorMode
        self.backgroundShape = backgroundShape
        self.border = border
        self.action = action
    }
}

struct ButtonModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
