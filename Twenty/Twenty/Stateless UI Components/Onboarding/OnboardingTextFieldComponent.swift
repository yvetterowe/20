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
            .frame(maxHeight: 56)
    }
}

//add bottom border
extension UITextField {
  func useUnderline() -> Void {
    let border = CALayer()
    let borderWidth = CGFloat(2.0) // Border Width
    border.borderColor = UIColor.red.cgColor
    border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}


struct OnboardingTextFieldComponent: View {
    var label: String
    var text: Binding<String>
    var image: String?
    @State private var isEditing = false
    
    var body: some View {
        ZStack(alignment: .leading){
                Text(label)
                    .font(Font.custom("VarelaRound-Regular", size: 18))
                    .foregroundColor(Color.White)
                    .opacity(0.5)

                HStack{
                    TextField(
                        "",
                        text: text,
                        onEditingChanged: { _ in print("changed") },
                        onCommit: { print("commit") }
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
        Divider()
            .background(Color.white).opacity(0.5)
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
