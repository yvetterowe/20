//
//  GridStack.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct GridStack<Cell: View>: View {
    var model: Model
    struct Model {
        let numberOfRow: Int
        let numberOfColumns: Int
        let cell: (Int, Int) -> Cell
        let cellSize: CGSize
        let backgroundColor: Color
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< model.numberOfRow, id: \.self) { row in
                HStack(spacing:0) {
                    ForEach(0 ..< self.model.numberOfColumns, id: \.self) { column in
                        self.model.cell(row, column)
                        .frame(
                            width: self.model.cellSize.width,
                            height: self.model.cellSize.height
                        )
                    }
                }
            }
        }
        .background(model.backgroundColor)
    }
}

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack(
            model: .init(
                numberOfRow: 5,
                numberOfColumns: 4,
                cell: { row, column in
                    return row == column ? Text("") : Text("\(row)-\(column)")
                },
                cellSize: .init(width: 40, height: 40),
                backgroundColor: .blue
            )
        )
    }
}
