//
//  SecondaryTextButtonStyle.swift
//  Twenty
//
//  Created by Effy Zhang on 3/4/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct LightSecondaryTextButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.custom("VarelaRound-Regular", size: 18))
            .foregroundColor(Color.White)
            .frame(maxWidth:.infinity, maxHeight: 56)
            .padding(20)
            
    }
}

struct SecondaryTextButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ColorManager.Blue.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Button("Secondary Text Button"){}
                .buttonStyle(LightSecondaryTextButtonStyle())
        }

            
    }
}
