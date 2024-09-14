//
//  ContentView.swift
//  Erdgas
//
//  Created by Kubilay Erdogan on 2023-02-18.
//

import SwiftUI

struct ContentView: View {
    @State var measurements: [Measurement] = []
    @State var isPresentingAddEntryView = false
    let dataStore: DataStore = UserDefaultsDataStore.shared

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(measurements, id: \.id) { measurement in
                        HStack {
                            Text(String(format: "%.3f", measurement.value).replacingOccurrences(of: ".", with: ","))
                            Spacer()
                            Text(measurement.date, style: .date)
                            Text(measurement.date, style: .time)
                        }
                        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    }
                }
                .navigationTitle("Erdgas")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isPresentingAddEntryView = true
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
                .sheet(isPresented: $isPresentingAddEntryView) {
                    let preselectedValue = measurements.first?.value ?? 0
                    AddUpdateEntryView(
                        preselectedValue: preselectedValue) { measurement in
                            dataStore.add(measurement)
                            reload()
                        }
                }
            }
            .onAppear {
                reload()
            }
        }
    }

    func reload() {
        measurements = UserDefaultsDataStore.shared
            .getAll()
            .sorted(by: { $0.date > $1.date })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
