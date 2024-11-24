//
//  LoginFirebaseManager.swift
//  WA8_Doshi_6855
//
//  Created by Dhruv Doshi on 11/9/24.
//

import Foundation
import FirebaseAuth

extension LoginViewController{
    
    func signInToFirebase(email: String, password: String){
        showActivityIndicator()
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
                // Take user to the chats screen instead of print
                self.navigateToChatRecordScreen()
                self.hideActivityIndicator()
            } else{
                //MARK: alert that no user found or password wrong...
                self.hideActivityIndicator()
                self.showErrorAlert(message: "Invalid email or password")
            }
        })
    }
    
    func navigateToChatRecordScreen() {
        let chatRecordVC = ViewController()
        navigationController?.setViewControllers([chatRecordVC], animated: true)
    }
}
