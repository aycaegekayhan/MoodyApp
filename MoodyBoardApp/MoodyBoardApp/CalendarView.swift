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

    var body: some View {
        VStack(spacing: 20) {
            DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())
                .background(
                    userSelectionStore.selections
                        .filter { $0.dateString == DateFormatter.dateOnly.string(from: selectedDate) }
                        .first.map { selection in
                            Circle()
                                .fill(selection.color.colorValue)
                                .frame(width: 30, height: 30)
                                .offset(y: -40) // Adjust as needed for your layout
                        }
                )

            if let feeling = userSelectionStore.selections.first(where: { $0.dateString == DateFormatter.dateOnly.string(from: selectedDate) })?.feeling {
                Text(feeling)
            }
            
            Button("Close") {
                isPresented = false
            }
        }
        .padding()
    }
}


