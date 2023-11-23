//
//  NoteModel.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct NoteModel: Identifiable, Codable {
    var id: String
    var userID: String
    var createBy: String
    var name: String
    var description: String
}
