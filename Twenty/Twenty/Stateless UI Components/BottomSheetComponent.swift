//
//  BottomSheetComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/23/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
    static let headerHeight: CGFloat = 56
}

struct BottomSheetComponent<Content: View, NavigationLeadingItem: View, NavigationTrailingItem: View>: View {
    @Binding var isOpen: Bool
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    let title: String
    private let navigationLeadingItem: () -> NavigationLeadingItem?
    private let navigationTrailingItem: () -> NavigationTrailingItem?
    
    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }

    init(
        isOpen: Binding<Bool>,
        maxHeight: CGFloat,
        title: String,
        @ViewBuilder navigationLeadingItem: @escaping () -> NavigationLeadingItem?,
        @ViewBuilder navigationTrailingItem: @escaping () -> NavigationTrailingItem?,
        @ViewBuilder content: () -> Content
    ) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self.title = title
        self.navigationLeadingItem = navigationLeadingItem
        self.navigationTrailingItem = navigationTrailingItem
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                BottomSheetHeaderComponent(
                    title: self.title,
                    navigationLeadingItem: self.navigationLeadingItem,
                    navigationTrailingItem: self.navigationTrailingItem
                )
                self.content
                Spacer()
                self.indicator.padding()
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
            .offset(y: isOpen ? 0 : UIScreen.main.bounds.height)
            .background(
                Color.black.opacity(isOpen ? 0.3 : 0).ignoresSafeArea()
                    .onTapGesture(perform: {
                        withAnimation{isOpen.toggle()}
                    })
            )
        }
    }
}

extension View {
    func bottomSheet<Content: View, NavigationLeadingItem: View, NavigationTrailingItem: View>(
        isOpen: Binding<Bool>,
        maxHeight: CGFloat,
        title: String,
        @ViewBuilder navigationLeadingItem: @escaping () -> NavigationLeadingItem?,
        @ViewBuilder navigationTrailingItem: @escaping () -> NavigationTrailingItem?,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            BottomSheetComponent<Content, NavigationLeadingItem, NavigationTrailingItem>(
                isOpen: isOpen,
                maxHeight: maxHeight,
                title: title,
                navigationLeadingItem: navigationLeadingItem,
                navigationTrailingItem: navigationTrailingItem,
                content: content
            )
        }
    }
}

struct BottomSheetComponent_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetComponent<VStack<TupleView<(Text, Text)>>, Button<Text>, Button<Text>>(
            isOpen: .constant(true),
            maxHeight: 300,
            title: "Title",
            navigationLeadingItem: { Button("Cancel") {} },
            navigationTrailingItem: { Button("Done") {} }
        ) {
            VStack {
                Text("hello")
                Text("world")
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
