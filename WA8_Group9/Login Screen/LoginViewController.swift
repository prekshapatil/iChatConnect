//
//  ViewController.swift
//  WA8_Doshi_6855
//
//  Created by Dhruv Doshi on 11/9/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginScreen = LoginView()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title="Login"
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonClickLoginTapped), for: .touchUpInside)
        loginScreen.buttonRegister.addTarget(self, action: #selector(onButtonClickRegisterTapped), for: .touchUpInside)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onButtonClickLoginTapped(){
        // Collect entered information
        if let email = loginScreen.textFieldEmail.text, let password = loginScreen.textFieldPassword.text {
            
            // Check if both fields are empty
            if email.isEmpty && password.isEmpty {
                showErrorAlert(message: "Both email and password are required.")
                return
            }
            
            // Check if email is empty
            if email.isEmpty {
                showErrorAlert(message: "Please enter your email.")
                return
            }
            
            // Check if password is empty
            if password.isEmpty {
                showErrorAlert(message: "Please enter your password.")
                return
            }
            
            // If both fields are non-empty, attempt login
            loginUserAPI(email: email, password: password)
        }
    }
    @objc func onButtonClickRegisterTapped() {
        let registerViewController = RegisterViewController()
        navigationController?.setViewControllers([registerViewController], animated: true)
    }
    
    func loginUserAPI(email: String, password: String){
        signInToFirebase(email: email, password: password)
    }
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

