//
//  DataStore.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI
import FirebaseDatabase
import FirebaseDatabaseSwift

class DataStore: ObservableObject {
    
    @Published var notes: [NoteModel] = []
    
    private let ref = Database.database().reference()
    
    func pushNote(noteModel: NoteModel, _ completion: @escaping ()->Void) {
        let dic = ["userID": noteModel.userID, "name": noteModel.name, "createBy": noteModel.createBy, "description": noteModel.description]
        ref.child("Notes").child(noteModel.id).setValue(dic)
        completion()
    }
    
    func fetchNotes() {
        ref.child("Notes").observe(.value) { snapShot, _  in
            guard let value = snapShot.value as? [String: [String: String]] else { return }
            self.notes = value.compactMap { key, value in
                return NoteModel(id: key, userID: value["userID"] ?? "", createBy: value["createBy"] ?? "", name: value["name"] ?? "", description: value["description"] ?? "")}
        }
    }
    
    func pushAcount(userModel: UserModel, _ completion: @escaping () -> Void){
        let dic = ["userName": userModel.userName, "passWord": userModel.passWord]
        ref.child("Account").child(userModel.userID).setValue(dic)
        completion()
    }
    
    func login(userName: String, password: String, _ completion: @escaping (UserModel) -> Void, failure: @escaping (String) -> Void ){
        ref.child("Account")
            .queryOrdered(byChild: "userName")
            .queryEqual(toValue: userName)
            .observe(.value) { snapShot, _ in
                guard let value = snapShot.value as? [String: [String: String]] else {
                    failure("Something error")
                    return
                }
               _ = value.compactMap { key, value in
                    if let _password = value["passWord"] , password == _password {
                        let userName = value["userName"]
                        let userModel = UserModel(userID: snapShot.key, userName: userName ?? "", passWord: "")
                        completion(userModel)
                    } else {
                        failure("Wrong password")
                    }
                }
            }
    }
}
