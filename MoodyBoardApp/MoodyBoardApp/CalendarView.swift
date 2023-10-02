//
//  CalendarView.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 10/2/23.
//

import SwiftUI

struct CalendarView: View {
    @Binding var isPresented: Bool
    @State private var selectedDate: Date = Date()
    @ObservedObject var userSelectionStore: UserSelectionStore

    var selectedColor: Color? {
        userSelectionStore.selections.first(where: { $0.dateString == DateFormatter.dateOnly.string(from: selectedDate) })?.color.colorValue
    }

    var body: some View {
        VStack(spacing: 20) {
            DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())

            if let feeling = userSelectionStore.selections.first(where: { $0.dateString == DateFormatter.dateOnly.string(from: selectedDate) })?.feeling {
                Text(feeling)
            }

            Button("Close") {
                isPresented = false
            }
        }
        .padding()
        .background(selectedColor ?? Color.white)  // Change only the background of the CalendarView
        .edgesIgnoringSafeArea(.all)
    }
}









