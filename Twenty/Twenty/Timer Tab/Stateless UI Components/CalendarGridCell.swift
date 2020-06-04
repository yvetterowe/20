//
//  CalendarGridCell.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct CalendarGridCell: View {
    var model: Model
    struct Model {
        var cell: Cell
        enum Cell {
           case empty
           case button(ButtonModel)
        }
    }
    
    var body: some View {
        switch model.cell {
        case .empty:
            return TextButton.calendarGridCellPlaceholder
        case let .button(buttonModel):
            return TextButton(model: buttonModel)
        }
    }
}

private extension TextButton {
    
    static let calendarGridCellPlaceholder: TextButton = .init(
        model: .init(
            textModel: .init(text: "", textColor: .clear, textFont: .title),
            backgroundColorMode: .single(.clear),
            action: {}
        )
    )
}

struct CalendarGridCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CalendarGridCell(model: .init(cell: .empty))
            CalendarGridCell(
                model: .init(
                    cell: .button(
                        .init(
                            textModel: .init(text: "25", textColor: .black, textFont: .title),
                            backgroundColorMode: .single(.blue),
                            backgroundShape: .circle(radius: 5),
                            action: {}
                        )
                    )
                )
            )
            CalendarGridCell(
                model: .init(
                    cell: .button(
                        .init(
                            textModel: .init(text: "31", textColor: .white, textFont: .title),
                            backgroundColorMode: .single(.pink),
                            backgroundShape: .circle(radius: 24),
                            action: {}
                        )
                    )
                )
            )
        }
        .border(.some(color: .black, width: 1, cornerRadius: 0))
    }
}
