//
//  DataModels.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 9/26/23.
//

import SwiftUI
import Foundation

struct UserSelection: Codable, Identifiable {
    let id = UUID()
    let date: Date
    let color: ColorType
    let feeling: String

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
enum ColorType: String, Codable, CaseIterable {
    case red, blue, green, yellow, purple
}

extension ColorType {
    var colorValue: Color {
        switch self {
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


