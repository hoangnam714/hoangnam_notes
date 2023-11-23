//
//  NotesView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var dataStoreApp: DataStoreApp
    
    @State var selected = 0
    var body: some View {
        VStack {
            Picker(selection: $selected, label: Text(""), content: {
                Text("My Note").tag(0)
                Text("All Notes").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 100)
            LazyVStack(spacing: 10) {
                let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
                let notes = selected == 0 ? dataStoreApp.notes.filter({$0.userID == userID}) : dataStoreApp.notes.filter({$0.userID != userID})
                if notes.isEmpty {
                    Text("No note available")
                        .padding()
                } else {
                    ForEach(notes, id: \.id ) { item in
                        noteItemView(noteModel: item)
                    }
                }
            }
        }
        .frame( maxHeight: .infinity ,alignment: .top)
        .onAppear {
            dataStoreApp.fetchNotes()
        }
    }
    
    @ViewBuilder
    func noteItemView(noteModel: NoteModel) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(noteModel.name)
                    .font(.title)
                Text(noteModel.description)
                    .font(.subheadline)
                Text("create by: \(noteModel.createBy)")
                    .font(.system(size: 12))
            }
            .padding()
            Divider()
        }
    }
}

#Preview {
    NotesView()
}
