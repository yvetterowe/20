//
//  UnwrapView.swift
//  Twenty
//
//  Created by Hao Luo on 6/6/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

// https://www.swiftbysundell.com/tips/optional-swiftui-views/
struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}
