//
//  PrimaryTextButton.swift
//  Twenty
//
//  Created by Effy Zhang on 2/21/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct LightPrimaryTextButtonStyle: ButtonStyle {
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

struct DarkPrimaryTextButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.custom("VarelaRound-Regular", size: 18))
            .foregroundColor(Color.White)
            .background(
                Capsule()
                    .fill(ColorManager.Blue)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 56)
                    .padding(.all, 20)
            )
            .frame(maxWidth:.infinity, maxHeight: 56)
            .padding(20)
            
    }
}

struct PrimaryTextButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ColorManager.Blue.edgesIgnoringSafeArea(.all)
            VStack{
                Button("Light Primary Text Button"){}
                    .buttonStyle(LightPrimaryTextButtonStyle())
                Button("Dark Primary Text Button"){}
                    .buttonStyle(DarkPrimaryTextButtonStyle())
            }

        }
       
    }
}
