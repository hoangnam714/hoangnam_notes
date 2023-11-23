//
//  TabbarView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct TabbarView: View {
    @State var tabSelection: Int = 0
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $tabSelection){
                    NotesView()
                        .tag(0)
                    CreateNoteView()
                        .tag(1)
                    ProfileView()
                        .tag(2)
                    
                }
                HStack(alignment: .center, spacing: 0) {
                    VStack {
                        tabSelection == 0 ? Color.gray : Color.gray.opacity(0.3)
                    }
                    .background()
                    .overlay {
                        Image(.notes2)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFill()
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        tabSelection = 0
                    }
                    VStack {
                        tabSelection == 1 ? Color.gray : Color.gray.opacity(0.3)
                    }
                    .overlay {
                        Image(.notes)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFill()
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        tabSelection = 1
                    }
                    VStack {
                        tabSelection == 2 ? Color.gray : Color.gray.opacity(0.3)
                    }
                    .overlay {
                        Image(.account)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFill()
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        tabSelection = 2
                    }
                }
                .frame(height: 40)
                .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    TabbarView()
}
