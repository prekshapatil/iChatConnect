//
//  RegisterViewController.swift
//  App10
//
//  Created by Dhruv Doshi on 10/27/24.
//

import UIKit

class RegisterViewController: UIViewController {

    let registerScreen = RegisterView()
    let childProgressView = ProgressSpinnerViewController()
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        title="Register"
        registerScreen.buttonLogin.addTarget(self, action: #selector(onButtonClickLoginTapped), for: .touchUpInside)
        registerScreen.buttonRegister.addTarget(self, action: #selector(onButtonClickRegisterTapped), for: .touchUpInside)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onButtonClickLoginTapped(){
        let loginViewController = LoginViewController()
        navigationController?.setViewControllers([loginViewController], animated: true)
    }

    @objc func onButtonClickRegisterTapped() {
        
        // collect entered information
        if let name = registerScreen.textFieldName.text,
           let email = registerScreen.textFieldEmail.text,
           let password = registerScreen.textFieldPassword.text,
           let verifyPassword = registerScreen.textFieldVerifyPassword.text {
            
            // Check if all fields are filled
            if name.isEmpty || email.isEmpty || password.isEmpty || verifyPassword.isEmpty {
                showErrorAlert(message: "All fields are required.")
                return
            }
            
            // Validate password length (minimum 4 characters)
            if !validatePassword(password) {
                showErrorAlert(message: "Password must be at least 4 characters.")
                return
            }
            
            // Check if passwords match
            if password != verifyPassword {
                showErrorAlert(message: "Passwords do not match.")
                return
            }
            
            // Validate email
            if isValidEmail(email) {
                registerUserAPI(name: name, email: email, password: password)
            } else {
                showErrorAlert(message: "Invalid email ID.")
            }
        }
    }
    
    func registerUserAPI(name: String, email: String, password: String){
        registerNewAccount()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        return password.count >= 4
    }
    
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}
