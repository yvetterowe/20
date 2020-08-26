//
//  StatisticView.swift
//  Twenty
//
//  Created by Hao Luo on 8/25/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct StatisticView: View {
    
    struct ViewModel {
        let cells: [[StatisticCell.ViewModel]]
    }
    
    let viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<viewModel.cells.count) { row in
                HStack {
                    ForEach(0..<viewModel.cells[row].count) { column in
                        StatisticCell(viewModel: viewModel.cells[row][column])
                    }
                }
            }
        }
    }
    
    static func placeholder() -> some View {
        return StatisticView(
            viewModel: .init(
                cells: [
                    [
                        .init(imageModel: .init(type: .system("number.square")), title: "8.2h", subtitle: "To milestone"),
                        .init(imageModel: .init(type: .system("number.square")), title: "1h 15min", subtitle: "Avg everyday"),
                    ],
                    [
                        .init(imageModel: .init(type: .system("number.square")), title: "12", subtitle: "records count"),
                        .init(imageModel: .init(type: .system("number.square")), title: "7", subtitle: "strike"),
                    ],
                ]
            )
        ).frame(height: 130)
    }
}

struct StatisticCell: View {
   
    struct ViewModel {
        let imageModel: Image.Model
        let title: String
        let subtitle: String
    }
    
    let viewModel: ViewModel
    
    var body: some View {
        HStack {
            Image(model: viewModel.imageModel)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(viewModel.title)
                Text(viewModel.subtitle)
            }
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView.placeholder()
    }
}
