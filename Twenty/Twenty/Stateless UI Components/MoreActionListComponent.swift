//
//  MoreActionListComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct MoreActionListComponent: View {
    let rows: [MoreActionRowComponent]
    let rowHeight: CGFloat = 56
    
    
    var body: some View {
        NavigationView{
            List(0..<rows.count) { rowIndex in
                Button(action: rows[rowIndex].tapAction) {
                    rows[rowIndex]
                }
                .frame(height: rowHeight)
            }
            .navigationBarTitle("Actions")
        }
        }
        
}

struct MoreActionListComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreActionListComponent(
            rows: [
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Add Time",
                    tapAction: {},
                    isActionDistructive: false
                ),
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Edit Goal",
                    tapAction: {},
                    isActionDistructive: false
                ),
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "View actvities",
                    tapAction: {},
                    isActionDistructive: false
                ),
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Delete Goal",
                    tapAction: {},
                    isActionDistructive: true
                )
            ]
        )
        
    }

}
