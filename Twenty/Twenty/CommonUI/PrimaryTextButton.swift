//
//  PrimaryTextButton.swift
//  Twenty
//
//  Created by Effy Zhang on 2/21/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct PrimaryTextButtonStyle: ButtonStyle {
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
    }
}

struct PrimaryTextButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ColorManager.Blue.edgesIgnoringSafeArea(.all)
            Button("Primary Text Button"){}
                .buttonStyle(PrimaryTextButtonStyle())
        }
       
    }
}
