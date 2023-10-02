//
//  DataModels.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 9/26/23.
//

import Foundation

struct UserSelection: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var color: ColorType
    var feeling: String
}

enum ColorType: String, Codable, CaseIterable {
    case red, blue, green, yellow, purple
}


