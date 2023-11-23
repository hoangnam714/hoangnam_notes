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
            Text("Profile")
                .font(.headline)
            Text("User name: \(UserDefaults.standard.string(forKey: "userName") ?? "Anonymous")")
            Button {
                UserDefaults.standard.set(false, forKey: "isLogin")
                UserDefaults.standard.set("", forKey: "userID")
                UserDefaults.standard.set("", forKey: "userName")
            } label: {
                Text("Logout")
            }
        }
        .frame(alignment: .top)
    }
}
