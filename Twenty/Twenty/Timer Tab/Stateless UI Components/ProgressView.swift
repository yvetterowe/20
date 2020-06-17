//
//  ProgressView.swift
//  Twenty
//
//  Created by Hao Luo on 6/11/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    
    var model: Model
    struct Model {
        var title: Text.Model
        var progressBar: ProgressBar.Model
        var progressBarWidth: CGFloat
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(self.model.title.text)
                    .foregroundColor(self.model.title.textColor)
                    .font(self.model.title.textFont)
                Spacer()
                ProgressBar(model: self.model.progressBar)
                    .frame(width: self.model.progressBarWidth)
            }.frame(height: geometry.size.height)
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(model: .init(
            title: .init(
                text: "10% Learn SwiftUI",
                textColor: .blue,
                textFont: .body
            ),
            progressBar: .init(
                progress: 0.2,
                foregroundColor: .blue,
                foregroundOpacity: 1.0,
                backgroundColor: .blue,
                backgroundOpacity: 0.3,
                cornerRadius: 8
            ),
            progressBarWidth: 102
            )
        ).frame(height: 20)
    }
}
