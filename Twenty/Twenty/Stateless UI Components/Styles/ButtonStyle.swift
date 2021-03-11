//
//  ButtonStyle.swift
//  Twenty
//
//  Created by Effy Zhang on 3/4/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct SecondaryTextButtonStyle: View {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.custom("VarelaRound-Regular", size: 18))
            .foregroundColor(ColorManager.Blue)
            .background(
                Capsule()
                    .fill(Color.White)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 56)
                    .padding(.all, 20)
            )
            .frame(maxWidth:.infinity, maxHeight: 56)
            .padding(20)
            
    }
}

struct SecondaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
       Button("Secondary Text Button")
        .buttonStyle(SecondaryTextButtonStyle())
    }
}

