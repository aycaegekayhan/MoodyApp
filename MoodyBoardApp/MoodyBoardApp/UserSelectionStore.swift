//
//  UserSelectionStore.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 10/2/23.
//

import Foundation
import SwiftUI

class UserSelectionStore: ObservableObject {
    @Published var selections: [UserSelection] = []

    func remove(at offsets: IndexSet) {
        selections.remove(atOffsets: offsets)
        saveToUserDefaults()
    }

    private func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(selections) {
            UserDefaults.standard.set(data, forKey: "UserSelections")
        }
    }
}
