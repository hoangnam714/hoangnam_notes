//
//  TabbarView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct TabbarView: View {
    @State var selectionIndex: Int = 0
    @Namespace var tabbarSelection
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectionIndex){
                    NotesView()
                        .tag(0)
                    CreateNoteView()
                        .tag(1)
                    ProfileView()
                        .tag(2)
                }
                .frame(maxHeight: .infinity)
                .tabViewStyle(.page)
                .animation(.none, value: selectionIndex)
                CustomTabar
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    var CustomTabar: some View {
        HStack(alignment: .center, spacing: 0) {
            TabItem(selectionIndex: $selectionIndex, tabIndex: 0, nameSpace: tabbarSelection)
            NavigationLink(destination: CreateNoteView()) {
                Image(.create)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .padding(.top, 5)
                    .foregroundStyle(Color.gray)
                    .scaledToFill()
            }
            TabItem(selectionIndex: $selectionIndex, tabIndex: 2, nameSpace: tabbarSelection)
        }
        .frame(height: 50)
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(hex: "B4BDA9").opacity(0.25))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

private struct TabItem: View {
    @Binding var selectionIndex: Int
    var tabIndex: Int
    var nameSpace: Namespace.ID
    
    var body: some View {
        VStack {
            Image(tabIndex == 0 ? .list : tabIndex == 1 ? .create : .setting)
                .resizable()
                .renderingMode(.template)
                .frame(width: 30, height: 30)
                .padding(.top, 5)
                .foregroundStyle(tabIndex == selectionIndex ? Color(hex: "89D02E") : Color.gray)
                .scaledToFill()
        }
        .background {
            VStack {
                if tabIndex == selectionIndex {
                    RoundedRectangle(cornerRadius: 1.5)
                        .fill(Color(hex: "89D02E"))
                        .frame(height: 3)
                        .matchedGeometryEffect(id: "Tab", in: nameSpace)
                }
                Spacer()
            }
        }
        .frame(width: 150, height: 35)
        .onTapGesture {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0.2)) {
                selectionIndex = tabIndex
            }
        }
    }
}

#Preview {
    TabbarView()
}
