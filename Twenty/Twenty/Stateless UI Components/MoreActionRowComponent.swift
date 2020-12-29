//
//  MoreActionRowComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct BtnText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("VarelaRound-Regular", size: 18))
            
    }
}

extension View {
    func btnTextStyle() -> some View {
        self.modifier(BtnText())
    }
}

struct MoreActionRowComponent: View {
    private let icon: Image
    private let title: String
    let tapAction: () -> Void
    private var isActionDistructive: Bool
   
    init(
        icon: Image,
        title: String,
        tapAction: @escaping () -> Void,
        isActionDistructive: Bool = false
    ) {
        self.icon = icon
        self.title = title
        self.isActionDistructive = false
        self.tapAction = tapAction
    }
    
    var body: some View {
        HStack {
            icon.resizable().aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(isActionDistructive ? ColorManager.Pink : ColorManager.Blue)
                .padding(8)
            Text(title)
                .btnTextStyle()
                .foregroundColor(isActionDistructive ? ColorManager.Pink : ColorManager.Blue)
            Spacer()
        }
    }
}

struct MoreActionRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreActionRowComponent(
            icon: Image(systemName: "number.square"),
            title: "Edit Goal",
            tapAction: {},
            isActionDistructive: false
        )
        .previewLayout(.fixed(width: 320, height: 40))
    }
}
