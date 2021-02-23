//
//  OnboardingTextFieldComponent.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI
struct InputFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .font(Font.custom("VarelaRound-Regular", size: 18))
            .foregroundColor(.white)
            .frame(maxHeight: 56)
    }
}


struct OnboardingTextFieldComponent: View {
    var label: String
    var text: Binding<String>
    var image: String?
    @State private var isEditing = false
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.wrappedValue == "" {
                Text(label)
                    .font(Font.custom("VarelaRound-Regular", size: 18))
                    .foregroundColor(Color.White)
                    .opacity(0.5)
            }

                HStack{
                    TextField(
                        "",
                        text: text,
                        onEditingChanged: { _ in isEditing = true },
                        onCommit: {   isEditing = false }
                    )
                    .textFieldStyle(InputFieldStyle())
                    
                    if (image != nil) {
                        Image(image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }

                }
        }
        if isEditing {
            Divider()
                .background(Color.red).opacity(1)
        }else{
            Divider()
                .background(Color.white).opacity(0.5)
        }
        
    }
}

struct OnboardingTextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ColorManager.MidGray.edgesIgnoringSafeArea(.all)
            OnboardingTextFieldComponent(label: "Username", text: .constant("Name"), image: "edit")
        }
        
    }
}
