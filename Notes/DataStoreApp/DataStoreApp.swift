//
//  DataStoreApp.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI
import FirebaseDatabase
import FirebaseDatabaseSwift

class DataStoreApp: ObservableObject {
    
    @Published var notes: [NoteModel] = []
    
    private let ref = Database.database().reference()
    
    func pushNote(noteModel: NoteModel, _ completion: @escaping ()->Void) {
        let dic = ["userID": noteModel.userID, "name": noteModel.name, "createBy": noteModel.createBy, "description": noteModel.description]
        ref.child("Notes").child(noteModel.id).setValue(dic)
        completion()
    }
    
    func fetchNotes() {
        ref.child("Notes").observe(.value) { snapShot, _  in
            guard let value = snapShot.value as? [String: [String: Any]] else { return }
            self.notes = value.compactMap { key, value in
                return NoteModel(id: key, userID: value["userID"] as? String ?? "", createBy: value["createBy"] as? String ?? "", name: value["name"] as? String ?? "", description: value["description"] as? String ?? "")}
        }
    }
}
