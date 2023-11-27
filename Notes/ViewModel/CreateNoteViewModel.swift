//
//  CreateNoteViewModel.swift
//  Notes
//
//  Created by admin on 27/11/2023.
//

import SwiftUI

class CreateNoteViewModel: ObservableObject {
    @Published var noteName: String = ""
    @Published var description: String = ""
    @Published var showSuccessAlert: Bool = false
    @Published var showFailureAlert: Bool = false
}
