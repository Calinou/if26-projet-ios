//
//  Combine+App.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 14/11/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import Combine

extension Publisher where Failure == Never {
    // TODO: remove when Combine supports ships with this operator.
    /// Support for publishers of non-optionals so that they can feed keypaths
    /// to optionals. This API is likely to be eventually added to Combine.
    func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Output?>, on object: Root) -> AnyCancellable {
        return map { .some($0) }.assign(to: keyPath, on: object)
    }
}
