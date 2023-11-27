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
                    Text("Login")
                        .font(.system(size: 42, weight: .bold))
                        .padding(.vertical, 50)
                    VStack(alignment: .leading) {
                        Text("User Name")
                            .font(.system(size: 16))
                        HStack {
                            Image(systemName: "person")
                                .font(.system(size: 20))
                                .opacity(0.5)
                            TextField("Type your username", text: $vm.userName)
                                .frame(height: 45)
                                .tint(Color.gray)
                                .accessibilityIdentifier("UserName")
                        }
                        .padding(.horizontal, 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                        Text("Password")
                            .font(.system(size: 16))
                            .padding(.top, 15)
                        HStack {
                            Image(systemName: "lock")
                                .font(.system(size: 20))
                                .opacity(0.5)
                            TextField("Type you password", text: $vm.passWord)
                                .frame(height: 45)
                                .tint(Color.gray)
                                .accessibilityIdentifier("Password")
                        }
                        .padding(.horizontal, 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    if let error = vm.error {
                        Text(error)
                            .font(.caption)
                            .foregroundStyle(.red)
                            .accessibilityIdentifier("Error")
                    }
                    
                    if vm.isSignUp {
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
                                .font(.system(size: 20, weight: .bold))
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(hex: "343436"))
                                }
                                .padding(.horizontal, 40)
                                .foregroundStyle(Color.white)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 150)
                        .accessibilityIdentifier("SignUp")
                        Text("Or Sign In with account")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.secondary)
                            .padding(.top, 50)
                        Button {
                            vm.isSignUp = false
                        } label: {
                            Text("Sign in")
                                .foregroundStyle(Color.black)
                                .font(.system(size: 18, weight: .bold))
                        }
                        .buttonStyle(.plain)
                        .accessibilityIdentifier("SignIn")
                    } else {
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
                            Text("Sign In")
                                .font(.system(size: 20, weight: .bold))
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(hex: "343436"))
                                }
                                .padding(.horizontal, 40)
                                .foregroundStyle(Color.white)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 150)
                        .accessibilityIdentifier("SignIn")
                        Text("Or")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.secondary)
                            .padding(.top, 50)
                        Button {
                            vm.isSignUp = true
                        } label: {
                            Text("SignUp")
                                .foregroundStyle(Color.black)
                                .font(.system(size: 18, weight: .bold))
                        }
                        .buttonStyle(.plain)
                        .accessibilityIdentifier("SignUp")
                    }
                    
                }
                .frame(minHeight: proxy.size.height ,alignment: .top)
            }
        }
    }
}

#Preview {
    LoginView()
}
