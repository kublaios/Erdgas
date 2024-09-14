//
//  Measurement.swift
//  Erdgas
//
//  Created by Kubilay Erdogan on 2023-02-19.
//

import Foundation

struct Measurement: Codable {
    let id: UUID
    let date: Date
    let value: Float

    init(id: UUID = UUID(), date: Date, value: Float) {
        self.id = id
        self.date = date
        self.value = value
    }
}
