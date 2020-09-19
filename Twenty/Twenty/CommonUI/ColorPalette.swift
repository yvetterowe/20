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

enum SementicColorPalette {
    
    // MARK: - Text
    
    static let defaultTextColor: Color = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return ColorPalette.white
        case .light:
            return ColorPalette.black
        case .unspecified:
            return ColorPalette.white
        @unknown default:
            fatalError()
        }
    }.color
    
    // MARK: - Button
    
    static let buttonTextColor: Color = SementicColorPalette.defaultTextColor
    static let buttonBorderColor: Color = ColorPalette.black.color
    
    // MARK: - Progress Bar
    
    static let progressBarColor: Color = SementicColorPalette.defaultTextColor
        
    // MARK: - Background
    
    static let timerGradient: LinearGradient = .init(
        gradient: .init(colors: [ColorPalette.pink.color,ColorPalette.orange.color]),
        startPoint: .init(x: 0.25, y: 0.5),
        endPoint: .init(x: 0.75, y: 0.5)
    )
}

private enum ColorPalette {
    static let white: UIColor = .white
    static let black: UIColor = .black
    static let pink: UIColor = .systemPink
    static let orange: UIColor = .systemOrange
}

extension UIColor {
    var color: Color {
        return Color(self)
    }
}

struct ColorPalette_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
