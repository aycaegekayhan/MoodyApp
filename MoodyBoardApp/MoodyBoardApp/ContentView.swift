//
//  ContentView.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 9/26/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var dailyMantra: String = ""
    @State private var selectedColor: ColorType? = nil
    @State private var userFeeling: String = ""
    @State private var userSelections: [UserSelection] = []
    @State private var isCalendarPresented: Bool = false
    @State private var selectedMood: Mood = .neutral
    @StateObject private var userSelectionStore = UserSelectionStore()
    

    let mantras = [
        "Stay positive and strong",
        "Believe in yourself",
        "You have the power to change your day",
        "Every challenge is an opportunity",
        "Happiness is a choice",
        // ... add as many as you like
    ]

    var body: some View {
        NavigationView {
            ZStack {
                            // 1. Background Gradient
                            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("Welcome to LAUNE App")
                        .foregroundColor(.white) // 3. Typography
                        .font(.system(size: 30, weight: .light, design: .serif))
                        //.italic()
                        .bold()
                    
                    Text(dailyMantra)
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 20) {
                        ForEach(ColorType.allCases, id: \.self) { color in
                            Circle()
                                .fill(self.color(for: color))
                                .frame(width: 40, height: 40)
                                .onTapGesture {
                                    withAnimation {  // 4. Animation
                                        selectedColor = color
                                    }
                                }
                                .overlay(
                                    Circle().stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
                                )
                                .shadow(radius: 5)   // Shadow
                        }
                    }
                    
                    TextField("How are you feeling?", text: $userFeeling)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Picker("Select your mood", selection: $selectedMood) {
                        ForEach(Mood.allCases) { mood in
                            Text(mood.rawValue).tag(mood)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .background(Color(UIColor.systemGray6)) // light greyish background
                    .cornerRadius(15)

                    
                    Button(action: {   // Begin the action closure for the button
                        if let color = selectedColor {
                            saveSelection(for: color, feeling: userFeeling, mood: selectedMood)
                        }
                    }) {    // End of action closure, begin the label closure for the button
                        Text("Save")
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(15)
                            .foregroundColor(.blue)
                            .shadow(radius: 5)
                    }   // End of label closure
                    .padding()  // Moved this padding outside of the Text view for the button

                }
                .navigationBarTitle(Text("Laune App"), displayMode: .inline)
                
                Spacer()  // This pushes the content below it to the bottom
                
                VStack {
                    Spacer()  // Pushes the content below it to the bottom
                    Button("Allow Notifications") {
                        NotificationManager.shared.requestNotificationPermission()
                    }
                    .onAppear {
                        NotificationManager.shared.scheduleDailyNotification()
                    }
                    .padding(.bottom, 10)  // Adjust this value as needed
                    .foregroundColor(.white)
                }

                
                

            }

            .fullScreenCover(isPresented: $isCalendarPresented) {
                CalendarView(isPresented: $isCalendarPresented, userSelectionStore: userSelectionStore)
                    .edgesIgnoringSafeArea(.all)
            }
            
            .navigationBarTitle(Text("Laune App"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    isCalendarPresented.toggle()
                }) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            )
        }
        .onAppear {
            displayDailyMantra()
            loadUserSelections()
            
        }
        
    }

    /*func saveSelection(for color: ColorType, feeling: String) {
        let selection = UserSelection(date: Date(), color: color, feeling: feeling)
            userSelections.append(selection)
            userSelectionStore.selections.append(selection)
            
            // Save to UserDefaults
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(userSelections) {
                UserDefaults.standard.set(data, forKey: "UserSelections")
            }
            
            userFeeling = ""
            selectedColor = nil
    }*/
    
    func saveSelection(for color: ColorType, feeling: String, mood: Mood, date: Date = Date()) {
        let selection = UserSelection(date: date, color: color, feeling: feeling, mood: selectedMood)
        userSelections.append(selection)
        userSelectionStore.selections.append(selection)
        
        // Save to UserDefaults
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(userSelections) {
            UserDefaults.standard.set(data, forKey: "UserSelections")
        }
        
        userFeeling = ""
        selectedColor = nil
    }

    
    func loadUserSelections() {
        if let data = UserDefaults.standard.data(forKey: "UserSelections") {
            let decoder = JSONDecoder()
            if let decodedSelections = try? decoder.decode([UserSelection].self, from: data) {
                userSelections = decodedSelections
                userSelectionStore.selections = decodedSelections
            }
        }
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
        case .teal:
            return Color.teal
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .purple:
            return Color.purple
        }
    }
}
