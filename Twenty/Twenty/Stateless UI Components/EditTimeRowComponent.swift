//
//  EditTimeRowComponent.swift
//  Twenty
//
//  Created by Hao Luo on 12/15/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct EditTimeRowComponent: View {
    let title: String
    let buttonTitle: String
    let buttonAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(ColorManager.MidGray)
            Spacer()
            Button(buttonTitle, action: buttonAction)
                .foregroundColor(ColorManager.Blue)
                
        }
        .font(Font.custom("VarelaRound-Regular", size: 18))
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}

struct EditTimeRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        EditTimeRowComponent(title: "Start at", buttonTitle: "Tue Jul 28 8:00 PM", buttonAction: {})
    }
}
