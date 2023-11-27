//
//  NoteDetailView.swift
//  Notes
//
//  Created by admin on 27/11/2023.
//

import SwiftUI

struct NoteDetailView: View {
    @EnvironmentObject var dataStore: DataStore
    @Environment(\.dismiss) var dismiss
    var noteModel: NoteModel
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Note name:")
                                .font(.headline)
                            Text(noteModel.name)
                                .padding(.leading, 6)
                                .padding(15)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                }
                                .padding(.bottom, 15)
                                .accessibilityIdentifier("NoteName")
                                .lineLimit(nil)
                            
                            Text("Description: ")
                                .font(.headline)
                            Text(noteModel.description)
                                .padding(.leading, 6)
                                .padding(15)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                }
                                .accessibilityIdentifier("NoteDescription")
                                .lineLimit(nil)
                        }
                    }
                    .padding(25)
                    .background(Color.white)

                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Note Detail")
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
