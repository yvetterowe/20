//
//  ProgressBar.swift
//  Twenty
//
//  Created by Hao Luo on 6/11/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    var model: Model
    struct Model {
        var progress: Float
        var foregroundColor: Color
        var foregroundOpacity: Double
        var backgroundColor: Color
        var backgroundOpacity: Double
        var cornerRadius: CGFloat
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .opacity(self.model.backgroundOpacity)
                    .foregroundColor(self.model.backgroundColor)

                Rectangle()
                    .frame(
                        width: min(CGFloat(self.model.progress)*geometry.size.width, geometry.size.width),
                        height: geometry.size.height
                    )
                    .opacity(self.model.foregroundOpacity)
                    .foregroundColor(self.model.foregroundColor)
                    .animation(.linear)
            }.cornerRadius(self.model.cornerRadius)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(model: .init(
            progress: 0.2,
            foregroundColor: .blue,
            foregroundOpacity: 1.0,
            backgroundColor: .blue,
            backgroundOpacity: 0.3,
            cornerRadius: 8)
        ).frame(height:20)
    }
}
