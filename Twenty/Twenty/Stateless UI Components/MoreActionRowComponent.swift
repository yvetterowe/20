//
//  MoreActionRowComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct MoreActionRowComponent<SheetContent: View>: View {
    private let icon: Image
    private let title: String
    let tapAction: () -> Void
    private let sheetContent: () -> SheetContent
    private var isSheetPresented: Binding<Bool>
    
    init(
        icon: Image,
        title: String,
        tapAction: @escaping () -> Void,
        isSheetPresented: Binding<Bool>,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self.icon = icon
        self.title = title
        self.tapAction = tapAction
        self.isSheetPresented = isSheetPresented
        self.sheetContent = sheetContent
    }
    
    var body: some View {
        HStack {
            icon.resizable().aspectRatio(contentMode: .fit)
            Text(title)
            Spacer()
        }
        .sheet(
            isPresented: isSheetPresented,
            content: sheetContent
        )
    }
}

struct MoreActionRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreActionRowComponent(
            icon: Image(systemName: "number.square"),
            title: "Edit Goal",
            tapAction: {},
            isSheetPresented: .constant(false)
        ) {
            Text("sheet content")
        }
        .previewLayout(.fixed(width: 320, height: 40))
    }
}
