//
//  SignUpLandingView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct SignUpLandingView: View {
    @State private var signUpButtonTapped = false
    @State private var signInButtonTapped = false

    
    
    let authService: AuthenticationService
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading){
                ColorManager.Blue.edgesIgnoringSafeArea(.all)
                
                VStack{
                    CoverView()

                    Spacer()
                    
                        NavigationLink(
                            destination: EmailSignUpView(store: .init(authService: authService)),
                            isActive: $signUpButtonTapped
                        ){
                        Button("Sign Up") {
                            signUpButtonTapped = true
                        }
                        .buttonStyle(LightPrimaryTextButtonStyle())
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Already have an account?").helperText()
                        NavigationLink(
                            destination: EmailSignInView(store: .init(authService: authService)),
                            isActive: $signInButtonTapped
                        ){
                            Button("Sign in") {
                                signInButtonTapped = true
                            }
                            .foregroundColor(Color.LightPink)
                            
                        }
                    }
                }
                .padding(20)
            }
        }
    }
}

struct SignUpLandingView_Previews: PreviewProvider {
    static var previews: some View {

            SignUpLandingView(authService: NoOpAuthService())

    }
}

struct CoverView: View {
    //state to trigger bolb rotate animation
    @State var show = false
    //state for 3d parallax effect
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Image(uiImage: #imageLiteral(resourceName: "logo.pdf") )
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 56, alignment: .topLeading)
                .offset(x: viewState.width/25, y: viewState.height/25)
                .scaleEffect(1.05)
            
            Text("Learn something new in 20hrs").headerText()
                .offset(x: viewState.width/15, y: viewState.height/15)
            Text("That learning curve differs immensely between various skills but Kauffman found that most skills can be acquired, at least at a basic level of proficiency, within just 20 hours. Just 20 hours of deliberate, focused practise is all you really need to build basic proficiency in any new skill.").bodyText()
                .offset(x: viewState.width/20, y: viewState.height/20)
        }
        .background(
            ZStack{
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y:-200)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .opacity(0.2)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .onAppear{self.show = true }
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y:-250)
                    .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
                    .blendMode(.overlay)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                    .onAppear{self.show = true }
            }
        )
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(
            Angle(degrees: 5),
            axis: (x: viewState.height, y: viewState.width, z: 0),
            anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
            anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
            perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
        )
        .scaleEffect(isDragging ? 0.9 : 1)
        .gesture(
            DragGesture()
                .onChanged{ value in
                    self.viewState = value.translation
                    self.isDragging = true
                }
                .onEnded{ value in
                    self.viewState = .zero
                    self.isDragging = false
                }
        )
    }
}
