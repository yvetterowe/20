//
//  ObservableWrapper.swift
//  Twenty
//
//  Created by Hao Luo on 9/9/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

final class ObservableWrapper<Value>: ObservableObject {
    @Published private(set) var value: Value!
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(publisher: AnyPublisher<Value, Never>) {
        print("hao-debug: ObservableWrapper init \(publisher)")
        publisher.sink { [unowned self] publishedValue in
            print("hao-debug: ObservableWrapper emit \(publishedValue)")
            self.value = publishedValue
        }.store(in: &cancellables)
    }
    
    deinit {
        print("hao-debug: ObservableWrapper deinit")
    }
}
