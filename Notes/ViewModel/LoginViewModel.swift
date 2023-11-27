//
//  LoginViewModel.swift
//  Notes
//
//  Created by admin on 27/11/2023.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var passWord: String = ""
    @Published var error: String? = nil
    @Published var isSignUp: Bool = false
}
