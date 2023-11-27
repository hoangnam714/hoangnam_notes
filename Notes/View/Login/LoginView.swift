//
//  LoginView.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var dataStore: DataStore
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    VStack {
                        TextField("User Name", text: $vm.userName)
                            .frame(height: 35)
                            .accessibilityIdentifier("tf_user_name")
                        Divider()
                        TextField("PassWord", text: $vm.passWord)
                            .frame(height: 35)
                            .accessibilityIdentifier("tf_pass_word")
                    }
                    .padding(25)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.gray.opacity(0.1))
                    }
                    .padding(.horizontal, 15)
                    
                    if let error = vm.error {
                        Text(error)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    Button {
                        if vm.userName != "", vm.passWord != "" {
                            let userID = UUID().uuidString
                            let userModel = UserModel(userID: userID, userName: vm.userName, passWord: vm.passWord)
                            dataStore.pushAcount(userModel: userModel) {
                                UserDefaults.standard.set(true, forKey: "isLogin")
                                UserDefaults.standard.set(userID, forKey: "userID")
                                UserDefaults.standard.set(vm.userName, forKey: "userName")
                            }
                        } else {
                            vm.error = "Username or password cannot be blank"
                        }
                    } label: {
                        Text("Sign Up")
                            .padding(15)
                            .background {
                                Color.white
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.gray, lineWidth: 1)
                                    }
                            }
                    }
                    .accessibilityIdentifier("btn_sign_up")
                    Button {
                        if vm.userName != "", vm.passWord != "" {
                            dataStore.login(userName: vm.userName, password: vm.passWord) { userModel in
                                UserDefaults.standard.set(true, forKey: "isLogin")
                                UserDefaults.standard.set(userModel.userID, forKey: "userID")
                                UserDefaults.standard.set(userModel.userName, forKey: "userName")
                            } failure: { error in
                                self.vm.error = error
                            }
                        } else {
                            vm.error = "Username or password cannot be blank"
                        }
                    } label: {
                        Text("Sign in")
                    }
                }
                .frame(minHeight: proxy.size.height ,alignment: .center)
                .accessibilityIdentifier("btn_sign_in")
            }
        }
    }
}

#Preview {
    LoginView()
}
