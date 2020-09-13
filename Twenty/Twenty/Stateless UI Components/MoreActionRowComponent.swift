//
//  MoreActionRowComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct MoreActionRowComponent: View {
    let icon: Image
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            icon.resizable().aspectRatio(contentMode: .fit)
            Text(title)
            Spacer()
        }
    }
}

struct MoreActionRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreActionRowComponent(
            icon: Image(systemName: "number.square"),
            title: "Edit Goal",
            action: {}
        ).previewLayout(.fixed(width: 320, height: 40))
    }
}
