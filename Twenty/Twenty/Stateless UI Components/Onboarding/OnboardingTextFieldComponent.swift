//
//  LightTextFieldComponent.swift
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
            .disableAutocorrection(true)
    }
}


struct LightTextFieldComponent: View {
    var label: String
    var text: Binding<String>
    var image: String?
    @State private var isEditing = false
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.wrappedValue == "" {
                Text(label).inputHintText()
            }

            HStack{
                TextField(
                    "",
                    text: text,
                    onEditingChanged: {isEditing in self.isEditing = isEditing}
                )
                .textFieldStyle(InputFieldStyle())
                .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                
                if (image != nil) {
                    Image(image ?? "edit").LightIconImage()
                }
            }
            Divider().frame(height: 1.0).background(Color.White).opacity(isEditing ? 1.0 : 0.2).offset(y:28)
        }.frame(height: 56)
    }
}

struct LightSecureFieldComponent: View {
    var label: String
    var text: Binding<String>
    var image: String?
//    @State private var isEditing = false
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.wrappedValue == "" {
                Text(label).inputHintText()
            }

            HStack{
                SecureField(
                    "",
                    text: text
                )
                .textFieldStyle(InputFieldStyle())
                .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                
                if (image != nil) {
                    Image(image ?? "edit").LightIconImage()
                }
            }
//            Divider().frame(height: 1.0).background(Color.White).opacity(isEditing ? 1.0 : 0.2).offset(y:28)
        }.frame(height: 56)
    }
}



struct LightTextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ColorManager.MidGray.edgesIgnoringSafeArea(.all)
            LightTextFieldComponent(label: "Username", text: .constant("Name"), image: "settings")
            LightSecureFieldComponent(label: "Username", text: .constant("Name"), image: "settings")
        }
        
    }
}
