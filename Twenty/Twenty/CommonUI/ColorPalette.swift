//
//  ColorPalette.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

enum ColorPalette {
    static let white: UIColor = .white
}

enum SementicColorPalette {
    
    static let buttonTextColor: Color = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return ColorPalette.white
        case .light:
            return ColorPalette.white
        case .unspecified:
            return ColorPalette.white
        @unknown default:
            fatalError()
        }
    }.color
    
}

extension UIColor {
    var color: Color {
        return Color(self)
    }
}
