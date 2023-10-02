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
    
    var body: some View {
            VStack(spacing: 20) {
                DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden() // this hides the label to only show the date picker.
                    .datePickerStyle(GraphicalDatePickerStyle())

                Button("Close") {
                    isPresented = false
                }
            }
            .padding()
        }
}

