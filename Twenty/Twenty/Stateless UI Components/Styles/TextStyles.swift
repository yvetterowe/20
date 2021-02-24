//
//  TextStyles.swift
//  Twenty
//
//  Created by Effy Zhang on 2/23/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

extension Text {

    func headerText() -> some View {
        self.foregroundColor(Color.white)
            .font(Font.custom("VarelaRound-Regular", size: 32))
            .frame(maxWidth: .infinity, alignment:.leading)
    }

    func bodyText() -> some View {
        self.foregroundColor(Color.white)
            .font(.custom("VarelaRound-Regular", size: 18))
            .multilineTextAlignment(.leading)
            .lineSpacing(4)
    }
    
    func buttonText() -> some View {
        self.foregroundColor(Color.white)
            .font(.custom("VarelaRound-Regular", size: 18))
            .lineLimit(1)
    }
    
    func linkButtonText() -> some View {
        self.foregroundColor(ColorManager.LightPink)
            .font(.custom("VarelaRound-Regular", size: 18))
            .lineLimit(1)
    }
    
    func inputHintText() -> some View {
        self.foregroundColor(Color.white).opacity(0.6)
            .font(.custom("VarelaRound-Regular", size: 18))
    }
    
    func inputLabelText() -> some View {
        self.foregroundColor(Color.white)
            .font(.custom("VarelaRound-Regular", size: 18))
    }
    
    func helperText() -> some View {
        self.foregroundColor(Color.white).opacity(0.6)
            .font(.custom("VarelaRound-Regular", size: 16))
            .multilineTextAlignment(.leading)
            .lineSpacing(4)
    }
    
    func errorText() -> some View {
        self.foregroundColor(ColorManager.Pink)
            .font(.custom("VarelaRound-Regular", size: 16))
            .multilineTextAlignment(.leading)
            .lineSpacing(4)
    }
}



struct TextStyles_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ColorManager.Blue.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading){
                Text("Header")
                   .headerText()

                Text("Super long body test")
                   .bodyText()

                Text("Helper text")
                   .helperText()

                Text("Input Hint")
                   .inputHintText()
 
                Text("Input Label")
                   .inputLabelText()
                
                Text("Link Button")
                   .linkButtonText()
                Text("Error Message")
                   .errorText()
            }
            
        }

    }
}
 
