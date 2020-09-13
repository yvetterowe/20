//
//  EditSheetComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct EditSheetComponent<Content>: View where Content: View{
    private let navigationBarTitle: String
    private let content: () -> Content
    private let onCancel: () -> Void
    private let onDone: () -> Void
    
    init(
        navigationBarTitle: String,
        onCancel: @escaping () -> Void,
        onDone: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.navigationBarTitle = navigationBarTitle
        self.onCancel = onCancel
        self.onDone = onDone
        self.content = content
    }
    
    var body: some View {
        NavigationView {
            content()
            .navigationBarTitle(navigationBarTitle)
            .navigationBarItems(
                leading: Button(action: onCancel) {
                    Text("Cancel")
                },
                trailing: Button(action: onDone) {
                    Text("Done")
                }
            )
        }
    }
}

struct EditSheetComponent_Previews: PreviewProvider {
    static var previews: some View {
        EditSheetComponent(
            navigationBarTitle: "Edit something",
            onCancel: {},
            onDone: {}) {
            Text("Hello world")
        }
    }
}
