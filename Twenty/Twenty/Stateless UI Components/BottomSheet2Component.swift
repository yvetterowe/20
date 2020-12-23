//
//  BottomSheet2Component.swift
//  Twenty
//
//  Created by Effy Zhang on 12/22/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct BottomSheet2Component: View {
    var body: some View {
        NavigationView {
            List(0..<20) {
                Text("\($0)")
            }
            .bottomSheet(isPresented: $isPresented, height: 300) {
                List(20..<40) { Text("\($0)") }
            }
            .navigationBarTitle("Bottom Sheet")
            .navigationBarItems(
                trailing: Button(action: { self.isPresented = true }) {
                    Text("Show")
                }
            )
        }
    }
}

struct BottomSheet2Component_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet2Component()
    }
}
