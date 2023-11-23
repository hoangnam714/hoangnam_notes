//
//  LoginView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State var userName: String = ""
    @State var passWord: String = ""
    @State var error: String? = nil
    
    var body: some View {
        VStack {
            TextField("User Name", text: $userName)
            TextField("PassWord", text: $passWord)
            if let error = error {
                Text(error)
                    .foregroundStyle(.red)
            }
            Button {
                if userName != "", passWord != "" {
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    UserDefaults.standard.set(UUID().uuidString, forKey: "userID")
                    UserDefaults.standard.set(userName, forKey: "userName")
                } else {
                     error = "Username or password cannot be blank"
                }
            } label: {
                Text("Sign Up")
            }
        }
    }
}

#Preview {
    LoginView()
}
