//
//  ImageStyles.swift
//  Twenty
//
//  Created by Effy Zhang on 2/28/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

extension Image {

    func DarkIconImage() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24)
            .foregroundColor(ColorManager.Blue)
            .padding(8)
    }
    
    func LightIconImage() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24)
            .foregroundColor(Color.White)
            .padding(8)
    }
}

struct ImageStyles_Previews: PreviewProvider {
    static var previews: some View {
        Image(uiImage: #imageLiteral(resourceName: "settings")).DarkIconImage()
    }
}
