//
//  LoginModel.swift
//  SwiftUITest
//
//  Created by Koneti Santhosh on 21/02/24.
//

import Foundation



class LoginViewModel: ObservableObject {
    
    @Published var userName:String = ""
    @Published var password:String = ""
    
    func loginAction() {
        
    }
    
}
