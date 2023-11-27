//
//  CreateNoteView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct CreateNoteView: View {
    @EnvironmentObject var dataStore: DataStore
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CreateNoteViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Note name:")
                        .font(.headline)
                    TextField("", text: $vm.noteName)
                        .padding(.leading, 6)
                        .frame(height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        }
                        .padding(.bottom, 15)
                        .accessibilityIdentifier("NoteName")
                    Text("Description: ")
                        .font(.headline)
                    TextEditor(text: $vm.description)
                        .padding(.leading, 6)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        }
                        .accessibilityIdentifier("NoteDescription")
                }
                Button {
                    if vm.noteName != "" {
                        let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
                        let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
                        dataStore.pushNote(noteModel: NoteModel(id: UUID().uuidString, userID: userID, createBy: userName, name: vm.noteName, description: vm.description)) {
                            self.vm.noteName = ""
                            self.vm.description = ""
                        }
                        self.vm.showSuccessAlert = true
                    } else {
                        self.vm.showFailureAlert = true
                    }
                } label: {
                    HStack {
                        Image(systemName: "doc.fill.badge.plus")
                            .font(.system(size: 24))
                        Text("Create new note")
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(Color.white)
                }
                .padding(15)
                .background {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color(hex: "89D02E"))
                }
                .buttonStyle(.plain)
                .padding(.top, 15)
                .accessibilityIdentifier("CreateNewNote")
            }
            .padding(25)
            .background(Color.white)
            .alert("Create note success", isPresented: $vm.showSuccessAlert) {
                Button("Okay", role: .cancel) {}
            }
            .alert("Name note can't blank", isPresented: $vm.showFailureAlert) {
                Button("Okay", role: .cancel) {}
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Create note")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("BackButton")
            }
        }
    }
}

#Preview {
    CreateNoteView()
}
