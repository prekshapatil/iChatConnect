//
//  RegisterFirebaseManager.swift
//  WA8_Doshi_6855
//
//  Created by Dhruv Doshi on 11/9/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount(){
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = registerScreen.textFieldName.text,
           let email = registerScreen.textFieldEmail.text?.lowercased(),
           let password = registerScreen.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name, email: email)
                }else{
                    print(error!)
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String, email: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.hideActivityIndicator()
                // Take user to chats screen instead of print
                print("User reistered successfully")
                self.saveUserToFirestore(name: name, email: email)
                self.navigateToChatRecordScreen()
            }else{
                //MARK: there was an error updating the profile...
                self.hideActivityIndicator()
                print("Error occured: \(String(describing: error))")
                self.showErrorAlert(message: "Registration failed. Try again.")
            }
        })
    }
    
    func navigateToChatRecordScreen() {
        let chatRecordVC = ViewController()
        navigationController?.setViewControllers([chatRecordVC], animated: true)
    }
    
    func saveUserToFirestore(name: String, email: String) {
        let database = Firestore.firestore()
        let userData: [String: Any] = [
            "name": name,
            "email": email
        ]
        database.collection("users").document(email).setData(userData) { error in
            self.hideActivityIndicator()
            if let error = error {
                print("error saving user to firestore: \(error.localizedDescription)")
                self.showErrorAlert(message: "failed to save user")
            } else {
                print("user registered and saved to firestore.")
                self.navigateToChatRecordScreen()
            }
        }
    }
}

