//
//  RegisterView.swift
//  App10
//
//  Created by Dhruv Doshi on 10/27/24.
//

import UIKit

class RegisterView: UIView {

    // MARK: Initialize variables
    var contentWrapper:UIScrollView!
    var imageLogo: UIImageView!
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textFieldVerifyPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupContentWrapper()
        setupImageLogo()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTextFieldVerifyPassword()
        setupButtonLogin()
        setupButtonRegister()
        initConstraints()
    }
    
    // MARK: set up UI elements
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    func setupImageLogo() {
        imageLogo = UIImageView()
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.image = UIImage(named: "wa8_logo")
        imageLogo.contentMode = .scaleAspectFit
        contentWrapper.addSubview(imageLogo)
        }
    func setupTextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.borderStyle = .roundedRect
        textFieldName.textAlignment = .left
        contentWrapper.addSubview(textFieldName)
    }
    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.textAlignment = .left
        textFieldEmail.keyboardType = .emailAddress
        contentWrapper.addSubview(textFieldEmail)
    }
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.textAlignment = .left
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.textContentType = .oneTimeCode
        contentWrapper.addSubview(textFieldPassword)
    }
     
    func setupTextFieldVerifyPassword() {
        textFieldVerifyPassword = UITextField()
        textFieldVerifyPassword.placeholder = "Verify Password"
        textFieldVerifyPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldVerifyPassword.borderStyle = .roundedRect
        textFieldVerifyPassword.textAlignment = .left
        textFieldVerifyPassword.isSecureTextEntry = true
        textFieldVerifyPassword.textContentType = .oneTimeCode
        contentWrapper.addSubview(textFieldVerifyPassword)
    }
    func setupButtonLogin(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.isUserInteractionEnabled = true
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.setTitle("Login", for: .normal)
        contentWrapper.addSubview(buttonLogin)
    }
    func setupButtonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.isUserInteractionEnabled = true
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.backgroundColor = UIColor.systemBlue
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.layer.cornerRadius = 8
        buttonRegister.layer.masksToBounds = true
        contentWrapper.addSubview(buttonRegister)
    }
    
    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            imageLogo.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 32),
            imageLogo.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            imageLogo.widthAnchor.constraint(equalToConstant: 100),
            imageLogo.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldName.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 32),
            textFieldName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldName.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant: 16),
            textFieldName.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant: 16),
            textFieldEmail.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            textFieldPassword.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            textFieldVerifyPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            textFieldVerifyPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldVerifyPassword.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            textFieldVerifyPassword.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),

            buttonRegister.topAnchor.constraint(equalTo: textFieldVerifyPassword.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonRegister.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            buttonRegister.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            buttonLogin.topAnchor.constraint(equalTo: buttonRegister.bottomAnchor, constant: 16),
            buttonLogin.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonLogin.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            buttonLogin.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor)
        ])
        contentWrapper.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }
    
    func configureTitleAppearance(navigationController: UINavigationController?) {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
