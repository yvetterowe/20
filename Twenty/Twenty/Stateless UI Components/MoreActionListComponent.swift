//
//  MoreActionListComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct MoreActionListComponent: View {
    let title: String
    let rows: [MoreActionRowComponent]
    let rowHeight: CGFloat = 56
    
    var body: some View {
        NavigationView{
            List(0..<rows.count) { rowIndex in
                Button(action: rows[rowIndex].action) {
                    rows[rowIndex]
                }
                .frame(height: rowHeight)
            }
            .navigationBarTitle(title)
        }
    }
}

struct MoreActionListComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreActionListComponent(
            title: "Learn SwiftUI",
            rows: [
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Add Time",
                    action: {}
                ),
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Edit Goal",
                    action: {}
                )
            ]
        )
    }
}
