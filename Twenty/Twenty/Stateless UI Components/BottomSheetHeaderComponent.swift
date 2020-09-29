//
//  BottomSheetHeaderComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/23/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI


struct BottomSheetHeaderComponent<NavigationLeadingItem: View, NavigationTrailingItem: View>: View {
    
    private let height: CGFloat
    private let navigationLeadingItem: NavigationLeadingItem?
    private let navigationTrailingItem: NavigationTrailingItem?
    private let title: String
    
    init(
        title: String,
        height: CGFloat = 56,
        @ViewBuilder navigationLeadingItem: () -> NavigationLeadingItem?,
        @ViewBuilder navigationTrailingItem: () -> NavigationTrailingItem?
    ) {
        self.title = title
        self.height = height
        self.navigationLeadingItem = navigationLeadingItem()
        self.navigationTrailingItem = navigationTrailingItem()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    self.navigationLeadingItem
                    Spacer()
                    Text("\(self.title)")
                    Spacer()
                    self.navigationTrailingItem
                }
                Divider()
            }
            .frame(height: height)
        }
    }
}

struct BottomSheetHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {}, navigationTrailingItem: {})
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {
                Text("Left")
            }, navigationTrailingItem: {
                
            })
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {
            }, navigationTrailingItem: {
                Text("Right")
            })
            BottomSheetHeaderComponent(title: "Title", navigationLeadingItem: {
                Text("Left")
            }, navigationTrailingItem: {
                Text("Right")
            })
        }
    }
}
