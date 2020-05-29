//
//  BorderMode.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

enum BorderMode {
    case none
    case some(color: Color, width: CGFloat, cornerRadius: CGFloat)
}

extension View {
    func border(_ borderMode: BorderMode) -> some View {
        switch borderMode {
        case .none:
            return AnyView(self)
        case let .some(color, width, cornerRadius):
            return AnyView(
                self.overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(color, lineWidth: width)
                )
            )
        }
    }
}
