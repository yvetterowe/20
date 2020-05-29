//
//  BackgroundColorMode.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

enum BackgroundColorMode {
    case single(Color)
    case gradient(LinearGradient)
}

extension Shape {
    func fill(_ backgroundColorMode: BackgroundColorMode) -> some View {
        switch backgroundColorMode {
        case let .single(color):
            return AnyView(self.fill(color))
        case let .gradient(gradient):
            return AnyView(self.fill(gradient))
        }
    }
}
