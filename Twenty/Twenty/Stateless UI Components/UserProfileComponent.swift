//
//  UserProfileComponent.swift
//  Twenty
//
//  Created by Hao Luo on 12/10/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct UserProfileComponent: View {
    
    let signOutAction: () -> Void
    
    var body: some View {
        Button("Sign Out", action: signOutAction)
    }
}

struct UserProfileComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileComponent(signOutAction: {})
    }
}
