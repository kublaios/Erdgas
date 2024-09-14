//
//  FoundationExtensions.swift
//  Erdgas
//
//  Created by Kubilay Erdogan on 2023-02-19.
//

import Foundation

extension Int {
    var asPowerOfTen: Float {
        Float(pow(10.0, Float(self)))
    }
}

extension Float {
    var asInteger: Int {
        Int(self)
    }
}
