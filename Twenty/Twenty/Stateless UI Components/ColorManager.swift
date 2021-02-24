//
//  ColorManager.swift
//  Twenty
//
//  Created by Effy Zhang on 11/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

// ColorManager.swift created by Brady Murphy
import SwiftUI

struct ColorManager {
    // create static variables for custom colors
    static let Pink = Color("Pink")
    static let Blue = Color("Blue")
    static let White = Color("White")
    static let UltraLightBlue = Color("UltraLightBlue")
    static let DarkGray = Color("DarkGray")
    static let MidGray = Color("MidGray")
    static let LightGray = Color("LightGray")
    static let LightPink = Color("LightPink")
    static let UltraLightGray = Color("UltraLightGray")
    

    

    //... add the rest of your colors here
}

// Or you can use an extension
// this will allow you to just type .spotifyGreen and you wont have to use ColorManager.spotifyGreen
extension Color {
    static let Pink = Color("Pink")
    static let Blue = Color("Blue")
    static let White = Color("White")
    static let UltraLightBlue = Color("UltraLightBlue")
    static let DarkGray = Color("DarkGray")
    static let MidGray = Color("MidGray")
    static let LightGray = Color("LightGray")
    static let LightPink = Color("LightPink")
    static let UltraLightGray = Color("UltraLightGray")
    // ... add the rest of your colors here
}
