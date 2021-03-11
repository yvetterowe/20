//
//  NewBottomSheetComponent.swift
//  Twenty
//
//  Created by Effy Zhang on 3/8/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI
fileprivate enum BottomSheetConstants {
    static let radius: CGFloat = 20
    static let indicatorHeight: CGFloat = 4
    static let indicatorWidth: CGFloat = 32
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}
struct BottomSheetView2<Content: View>: View {
    @Binding var isOpen: Bool
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    @GestureState private var translation: CGFloat = 0
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    private var indicator: some View {
        RoundedRectangle(cornerRadius: BottomSheetConstants.radius)
            .fill(Color("Asphalt60"))
            .frame(
                width: BottomSheetConstants.indicatorWidth,
                height: BottomSheetConstants.indicatorHeight
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = 157
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding(.top, 4)
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.systemBackground))
            .cornerRadius(BottomSheetConstants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                    let snapDistance = self.maxHeight * BottomSheetConstants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }.onEnded { value in
                    let snapDistance = self.maxHeight * BottomSheetConstants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}
struct BottomSheetView2_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView2(isOpen: .constant(true), maxHeight: 800) {
            Rectangle().fill(Color.white)
        }.edgesIgnoringSafeArea(.all)
    }
}
