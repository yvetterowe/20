//
//  ImageModel.swift
//  Twenty
//
//  Created by Hao Luo on 8/25/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

extension Image {
    struct Model {
        let type: ImageType
        enum ImageType {
            case system(String)
            case local(String)
        }
    }
    
    init(model: Model) {
        switch model.type {
        case let .system(name):
            self.init(systemName: name)
        case let .local(name):
            self.init(name)
        }
    }
}
