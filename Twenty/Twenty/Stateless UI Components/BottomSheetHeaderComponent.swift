//
//  BottomSheetHeaderComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/23/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct SubHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("VarelaRound-Regular", size: 18))
            .foregroundColor(ColorManager.DarkGray)
            
    }
}

extension View {
    func subHeaderStyle() -> some View {
        self.modifier(SubHeader())
    }
}


struct BottomSheetHeaderComponent<NavigationLeadingItem: View>: View {
    
    private let height: CGFloat
    private let navigationLeadingItem: NavigationLeadingItem?
    private let title: String
    
    init(
        title: String,
        height: CGFloat = 56,
        @ViewBuilder navigationLeadingItem: () -> NavigationLeadingItem?
    ) {
        self.title = title
        self.height = height
        self.navigationLeadingItem = navigationLeadingItem()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    self.navigationLeadingItem
                    Spacer()
                    Text("\(self.title)")
                        .subHeaderStyle()
                    Spacer()
                }
                Divider()
            }
            .frame(height: height)
        }.frame(height: height)
    }
}

struct BottomSheetHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {})
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {
                Text("Left")
                    .subHeaderStyle()
            })
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {
            })
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {
                Text("Left")
                    .subHeaderStyle()
            })
        }
    }
}
