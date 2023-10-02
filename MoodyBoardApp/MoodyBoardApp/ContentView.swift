//
//  ContentView.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 9/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var dailyMantra: String = ""
    @State private var selectedColor: ColorType? = nil
    @State private var userFeeling: String = ""
    @State private var userSelections: [UserSelection] = []
    @State private var isCalendarPresented: Bool = false


    let mantras = [
        "Stay positive and strong.",
        "Believe in yourself.",
        "You have the power to change your day.",
        "Every challenge is an opportunity.",
        "Happiness is a choice.",
        // ... add as many as you like
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Moody App")
                    .font(.largeTitle)
                    .padding()
                
                Text(dailyMantra)
                    .font(.title)
                    .padding()
                
                HStack(spacing: 20) {
                    ForEach(ColorType.allCases, id: \.self) { color in
                        Circle()
                            .fill(self.color(for: color))
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                selectedColor = color
                            }
                            .overlay(
                                Circle().stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
                            )
                    }
                }
                
                TextField("How are you feeling?", text: $userFeeling)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save") {
                    if let color = selectedColor {
                        saveSelection(for: color, feeling: userFeeling)
                    }
                }
                .padding()
                
            }
            .navigationBarTitle(Text("Moody App"), displayMode: .inline) // Optional: set a title
                .navigationBarItems(trailing:
                    Button(action: {
                        isCalendarPresented = true
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                )
            }
            .sheet(isPresented: $isCalendarPresented) {
                CalendarView(isPresented: $isCalendarPresented)
            }
            .onAppear {
                displayDailyMantra()
            }
        }
        

    func saveSelection(for color: ColorType, feeling: String) {
        let selection = UserSelection(date: Date(), color: color, feeling: feeling)
        userSelections.append(selection)
        // Reset for the next entry
        userFeeling = ""
        selectedColor = nil
    }

    func displayDailyMantra() {
        let today = Date()
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: today) ?? 1
        let mantraIndex = (dayOfYear - 1) % mantras.count
        dailyMantra = mantras[mantraIndex]
    }

    func color(for type: ColorType) -> Color {
        switch type {
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .purple:
            return Color.purple
        }
    }
}