//
//  PillButton.swift
//  Twenty
//
//  Created by Effy Zhang on 3/2/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack{
            Image
            configuration.label
                .font(Font.custom("VarelaRound-Regular", size: 18))
                .foregroundColor(ColorManager.Blue)
                .background(
                    Capsule()
                        .fill(Color.White)
                        .padding(20)
                        .border(ColorManager.Blue)
                )

        }

            
    }
}

struct PillButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            VStack{
                Button("Pill Button"){}
                    .buttonStyle(PillButtonStyle())
            
            }

        }
       
    }
}
