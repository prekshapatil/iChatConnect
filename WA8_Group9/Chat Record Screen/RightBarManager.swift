//
//  RightBarManager.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import UIKit
import FirebaseAuth

extension ViewController{
    func setupRightBarButton(isLoggedin: Bool){
        if isLoggedin{
            //user logged in
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            navigationItem.rightBarButtonItems = [barIcon, barText]
            
        }else{
            //user not logged in
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "person.fill.questionmark"),
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Sign in",
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            navigationItem.rightBarButtonItems = [barIcon, barText]
        }
    }
    
    @objc func onSignInBarButtonTapped(){
        
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
        
    }
    
    func signInToFirebase(email: String, password: String){
            //authenticate user
            Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
                if error == nil{
                    // Take user to the chats screen instead of print
                    print("user logged in")
                }else{
                    self.showErrorAlert(message: "Invalid email or password")
                }
            })
        }
    
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
    }
    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
                preferredStyle: .actionSheet)
            logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                    do{
                        try Auth.auth().signOut()
                    }catch{
                        print("Error occured!")
                    }
                })
            )
            logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(logoutAlert, animated: true)
    }
    
}

