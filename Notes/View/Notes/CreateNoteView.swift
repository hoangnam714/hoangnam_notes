//
//  CreateNoteView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct CreateNoteView: View {
    @EnvironmentObject var dataStoreApp: DataStoreApp
    @State var noteName: String = ""
    @State var description: String = ""
    @FocusState var focusDescription
    
    var body: some View {
        VStack {
            Text("Create note")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .font(.title)
            HStack {
                Text("Note name:")
                TextField("", text: $noteName)
                    .padding(.leading, 6)
                    .frame(height: 50)
                    .border(.secondary)
            }
            
            HStack(alignment: .top) {
                Text("Description")
                TextEditor(text: $description)
                    .padding(.leading, 6)
                    .border(.secondary)
            }
            Button {
                let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
                let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
                dataStoreApp.pushNote(noteModel: NoteModel(id: UUID().uuidString, userID: userID, createBy: userName, name: noteName, description: description)) {
                    self.noteName = ""
                    self.description = ""
                }
                
            } label: {
                Text("Create new note")
            }
        }
        .padding(.horizontal, 10)
        .frame(alignment: .topLeading)
    }
}

#Preview {
    CreateNoteView()
}
