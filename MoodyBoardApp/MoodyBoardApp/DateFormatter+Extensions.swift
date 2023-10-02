//
//  DateFormatter+Extensions.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 10/2/23.
//

import Foundation

extension DateFormatter {
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
