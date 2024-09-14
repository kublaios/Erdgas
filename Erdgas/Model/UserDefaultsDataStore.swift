//
//  UserDefaultsDataStore.swift
//  Erdgas
//
//  Created by Kubilay Erdogan on 2023-02-19.
//

import Foundation

protocol DataStore {
    func add(_ measurement: Measurement)
    func update(_ measurement: Measurement)
    func delete(_ measurement: Measurement)
    func getAll() -> [Measurement]
}

final class UserDefaultsDataStore: DataStore {
    static let shared = UserDefaultsDataStore()

    private let defaults = UserDefaults.standard
    private let key = "Measurements"

    private var measurements: [Measurement] {
        get {
            if let data = defaults.data(forKey: key),
               let storedMeasurements = try? JSONDecoder().decode([Measurement].self, from: data) {
                return storedMeasurements
            }
            return []
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                defaults.set(data, forKey: key)
                print("Data successfully saved")
            } catch {
                print("Error saving data: \(error)")
            }
        }
    }

    func add(_ measurement: Measurement) {
        var measurements = self.measurements
        measurements.append(measurement)
        self.measurements = measurements
    }

    func update(_ measurement: Measurement) {
        var measurements = self.measurements
        if let index = measurements.firstIndex(where: { $0.id == measurement.id }) {
            measurements[index] = measurement
            self.measurements = measurements
        }
    }

    func delete(_ measurement: Measurement) {
        var measurements = self.measurements
        if let index = measurements.firstIndex(where: { $0.id == measurement.id }) {
            measurements.remove(at: index)
            self.measurements = measurements
        }
    }

    func getAll() -> [Measurement] {
        return measurements
    }
}
