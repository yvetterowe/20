//
//  CalendarGridView.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct CalendarGridView: View {
    var model: Model
    struct Model {
        var backgroundColor: Color
        var cellSize: CGSize
        var cells: [[CalendarGridCell.Model]]
    }
    
    var body: some View {
        GridStack(
            model: .init(
                numberOfRow: model.cells.count,
                numberOfColumns: model.cells.first?.count ?? 0,
                cell: { CalendarGridCell(model: self.model.cells[$0][$1]) },
                cellSize: model.cellSize,
                backgroundColor: model.backgroundColor
            )
        )
    }
}

struct CalendarGridView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGridView(
            model: .init(
                backgroundColor: .blue,
                cellSize: .init(width: 60, height: 60),
                cells: [
                    [
                        .init(cell: .empty),
                        .init(circleButtonRadius: 5, text: "1"),
                        .init(circleButtonRadius: 10, text: "2"),
                    ],
                    [
                        .init(circleButtonRadius: 20, text: "3"),
                        .init(cell: .empty),
                        .init(circleButtonRadius: 5, text: "5"),
                    ],
                ]
            )
        )
    }
}

private extension CalendarGridCell.Model {
    init(circleButtonRadius: CGFloat, text: String) {
        self = .init(
            cell: .button(
                .init(
                    textModel: .init(text: text, textColor: .black, textFont: .title),
                    backgroundColorMode: .single(.pink),
                    backgroundShape: .circle(radius: circleButtonRadius),
                    action: {}
                )
            )
        )
    }
}
