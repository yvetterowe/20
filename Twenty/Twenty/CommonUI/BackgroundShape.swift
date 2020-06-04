//
//  BackgroundShape.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

enum BackgroundShape {
    case circle(radius: CGFloat)
    case roundedRectangle(cornerRadius: CGFloat)
}

extension View {
    func background(_ shape: BackgroundShape, _ colorMode: BackgroundColorMode) -> some View {
        switch shape {
        case let .circle(radius):
            return AnyView(self.background(
                ZStack {
                    Circle()
                    .fill(colorMode)
                    .frame(width: radius * 2, height: radius * 2)
                }
            ))
        
        case let .roundedRectangle(cornerRadius):
            return AnyView(self.background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(colorMode)
                }
            ))
        }
    }
}
