//
//  AddUpdateEntryView.swift
//  Erdgas
//
//  Created by Kubilay Erdogan on 2023-02-18.
//

import SwiftUI
import NumberWheelPicker

struct AddUpdateEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    private let pickerViewModel: DecimalNumberWheelPicker.ViewModel
    @State var date: Date
    let onSave: (Measurement) -> Void

    init(preselectedValue: Float, date: Date = Date(), onSave: @escaping (Measurement) -> Void) {
        pickerViewModel = .init(preselectedValue: preselectedValue, wholeParthLength: 4)
        _date = State(initialValue: date)
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("dar", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
                    .datePickerStyle(CompactDatePickerStyle())
                DecimalNumberWheelPicker(viewModel: pickerViewModel)
            }
            .padding()
            .navigationTitle("New entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let measurement = Measurement(date: date, value: pickerViewModel.selectedValue)
                        onSave(measurement)
                        dismiss()
                    } label: {
                        Text("Save")
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddUpdateEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateEntryView(preselectedValue: 987.65) { _ in }
    }
}
