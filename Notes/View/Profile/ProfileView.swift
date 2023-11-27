//
//  Profile.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Profile")
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.leading)
                VStack(alignment: .leading, spacing: 15) {
                    Image(systemName: "person.text.rectangle")
                        .font(.system(size: 75))
                        .padding(.top, 25)
                    Text("User name: ")
                        .font(.system(size: 18, weight: .bold))
                    + Text("\(UserDefaults.standard.string(forKey: "userName") ?? "Anonymous")")
                        .font(.system(size: 16))
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal, 35)
            
            Button {
                UserDefaults.standard.set(false, forKey: "isLogin")
                UserDefaults.standard.set("", forKey: "userID")
                UserDefaults.standard.set("", forKey: "userName")
            } label: {
                Text("Logout")
                    .foregroundStyle(.red)
                    .frame(alignment: .center)
            }
            .padding(.top, 200)
            .accessibilityIdentifier("btn_log_out")
            
            Spacer()
        }
        .frame( maxWidth: .infinity ,maxHeight: .infinity)
    }
}
