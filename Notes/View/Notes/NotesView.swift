//
//  NotesView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var dataStore: DataStore
    @StateObject var vm = NoteViewModel()
    private let columns = [GridItem(spacing: 10), GridItem()]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink {
                    CreateNoteView()
                } label: {
                    Image(.create)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color(hex: "89D02E"))
                        .frame(width: 25, height: 25)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("CreateNote")
            }
            .padding(.trailing, 20)
            
            Picker(selection: $vm.selectionTab, label: Text(""), content: {
                Text("My Note").tag(0)
                Text("All Notes").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 100)
            ScrollView {
                let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
                let notes = vm.selectionTab == 0 ? dataStore.notes.filter({$0.userID == userID}) : dataStore.notes.filter({$0.userID != userID})
                if notes.isEmpty {
                    Text("No note available")
                        .font(.subheadline)
                        .opacity(0.5)
                        .multilineTextAlignment(.center)
                        .frame(height: 300)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(notes, id: \.id ) { item in
                            noteItemView(noteModel: item)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .clipped()
        }
        .frame(maxHeight: .infinity ,alignment: .top)
        .onAppear {
            dataStore.fetchNotes()
        }
        .clipped()
    }
    
    @ViewBuilder
    func noteItemView(noteModel: NoteModel) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(noteModel.name)
                    .font(.headline)
                Text(noteModel.description)
                    .font(.subheadline)
                Spacer()
                Text("create by: \(noteModel.createBy)")
                    .font(.system(size: 8))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 200)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            }
        }
    }
}

#Preview {
    NotesView()
}
