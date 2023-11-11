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
    @State private var clickedEntryID: UUID?  // To store the clicked entry's ID
    @ObservedObject var userSelectionStore: UserSelectionStore
    @State private var showModal = false
    @State private var selectedMoodEntry: UserSelection?
    @State private var redrawKey: UUID = UUID()
    

    let gradient = LinearGradient(gradient: Gradient(colors: [Color(red: 243/255.0, green: 226/255.0, blue: 215/255.0), Color(red: 210/255.0, green: 205/255.0, blue: 240/255.0)]), startPoint: .top, endPoint: .bottom)

    var selectedColor: Color? {
        userSelectionStore.selections.first(where: { $0.dateString == DateFormatter.dateOnly.string(from: selectedDate) })?.color.colorValue
    }

    var body: some View {
            VStack(spacing: 20) {
                DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())

                List {
                    ForEach(userSelectionStore.selections, id: \.id) { selection in
                        SelectionRow(selection: selection, clickedEntryID: clickedEntryID)
                            .onTapGesture {
                                            selectedDate = selection.date
                                            clickedEntryID = selection.id
                                            selectedMoodEntry = selection
                                            showModal = true
                                            redrawKey = UUID() // Add this line
                                        }

                    }
                    .onDelete(perform: userSelectionStore.remove)
                }
                
                .listStyle(PlainListStyle())  // Add this line

                
                Button("Close") {
                    isPresented = false
                }
                .foregroundColor(.white)
            }
            .padding()
            .background(
                Group {
                    if let color = selectedColor {
                        color
                    } else {
                        gradient
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))

        // Display the modal view conditionally
        if showModal, let mood = selectedMoodEntry {
            withAnimation {
                MoodDetailView(moodEntry: mood, isDisplayed: $showModal)
                    .transition(.move(edge: .bottom))
            }
            
        }


    }
}

struct MoodDetailView: View {
    var moodEntry: UserSelection
    @Binding var isDisplayed: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isDisplayed = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                }
                .padding()
            }
            Spacer()
            Text(moodEntry.feeling)
                .padding()
            Spacer()
        }
        .background(Color.white)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SelectionRow: View {
    var selection: UserSelection
    var clickedEntryID: UUID?
    
    var body: some View {
        HStack {
            Text(selection.dateString).bold()
            .foregroundColor(Color.black.opacity(0.7))  // Make the color a bit subtle
            .font(.system(size: 15, weight: .light, design: .serif))
            Spacer()
            Text("\(selection.mood.rawValue)")
            .foregroundColor(Color.black.opacity(0.7))  // Make the color a bit subtle
                       }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                .background(selection.id == clickedEntryID ? Color.gray.opacity(0.3) : Color(UIColor.systemGray6))  // A light gray background
                .listRowBackground(Color.clear)
                .cornerRadius(15)  // Rounded corners for each row
    }
}

