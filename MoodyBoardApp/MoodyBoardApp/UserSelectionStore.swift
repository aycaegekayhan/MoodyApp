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
}

