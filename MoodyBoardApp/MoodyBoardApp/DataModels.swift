//
//  DataModels.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 9/26/23.
//

import SwiftUI
import Foundation

struct UserSelection: Codable, Identifiable {
    let id: UUID
    let date: Date
    let color: ColorType
    let feeling: String
    let mood: Mood

    init(id: UUID = UUID(), date: Date, color: ColorType, feeling: String, mood: Mood) {
        self.id = id
        self.date = date
        self.color = color
        self.feeling = feeling
        self.mood = mood
    }


    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
enum ColorType: String, Codable, CaseIterable {
    case red, teal, green, yellow, purple
}

extension ColorType {
    var colorValue: Color {
        switch self {
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

enum Mood: String, Codable, CaseIterable, Identifiable {
    case happy = "😃"
    case sad = "😢"
    case angry = "😠"
    case surprised = "😮"
    case neutral = "😐"
    
    var id: String { self.rawValue }
}


