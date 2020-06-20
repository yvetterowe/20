//
//  SwipeView.swift
//  Twenty
//
//  Created by Hao Luo on 6/20/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct SwipeView<SwipeItemModel, SwipeItemView>: View where SwipeItemModel: Hashable, SwipeItemView: View {
    
    private let itemViewBuilder: (SwipeItemModel) -> SwipeItemView
    private let model: Model
    struct Model {
        let initialIndex: Int
        let itemModels: [SwipeItemModel]
    }
    
    @State private var index: Int
    @State private var offset: CGFloat = 0
    @State private var isGestureActive: Bool = false
    
    init(
        model: Model,
        @ViewBuilder itemViewBuilder: @escaping (SwipeItemModel) -> SwipeItemView
    ) {
        self.model = model
        self.itemViewBuilder = itemViewBuilder
        self._index = .init(initialValue: model.initialIndex)
    }

    var body: some View {
        GeometryReader { geometry in
            return ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(self.model.itemModels, id: \.self) { itemModel in
                        self.itemViewBuilder(itemModel)
                            .frame(width: geometry.size.width)
                    }
                }
            }
            .content.offset(x: self.isGestureActive ? self.offset : -geometry.size.width * CGFloat(self.index))
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.isGestureActive = true
                        self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                    })
                    .onEnded({ value in
                        if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.model.itemModels.count - 1 {
                            self.index += 1
                        }
                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                            self.index -= 1
                        }
                        withAnimation { self.offset = -geometry.size.width * CGFloat(self.index) }
                        DispatchQueue.main.async { self.isGestureActive = false }
                    })
            )
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView(
            model: .init(
                initialIndex: 2,
                itemModels: [1,2,3,4,5,6,7]
        )) { item in
            Text("\(item)")
        }
    }
}
