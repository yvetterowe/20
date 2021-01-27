//
//  TextFieldComponent.swift
//  Twenty
//
//  Created by Hao Luo on 1/26/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct TextFieldComponent: View {
    let placeholder: String?
    @Binding var text: String
    var body: some View {
        TextField(placeholder ?? "", text: $text)
    }
}

struct TextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFieldComponent(placeholder: "Anything is impossible", text: .constant(""))
            TextFieldComponent(placeholder: "Anything is impossible", text: .constant("Learn SwiftUI"))
        }
    }
}
