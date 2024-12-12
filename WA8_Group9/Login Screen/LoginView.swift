//
//  LoginView.swift
//  App10
//
//  Created by Dhruv Doshi on 10/27/24.
//

import UIKit

class LoginView: UIView {

    // MARK: Initialize variables
    var contentWrapper:UIScrollView!
    var imageLogo: UIImageView!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupImageLogo()
        setupTextFieldEmail()
        setupTextFieldPassword()
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
    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.textAlignment = .left
        textFieldEmail.keyboardType = .emailAddress
        contentWrapper.addSubview(textFieldEmail)
    }
    func setupTextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.textAlignment = .left
        textFieldPassword.textContentType = .oneTimeCode
        textFieldPassword.isSecureTextEntry = true
        contentWrapper.addSubview(textFieldPassword)
    }
    func setupButtonLogin(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.isUserInteractionEnabled = true
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = UIColor.systemBlue
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.layer.cornerRadius = 8
        buttonLogin.layer.masksToBounds = true
        contentWrapper.addSubview(buttonLogin)
    }
    func setupButtonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.isUserInteractionEnabled = true
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        buttonRegister.setTitle("Register", for: .normal)
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
            
            textFieldEmail.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 32),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant:
            16),
            textFieldEmail.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            textFieldPassword.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            buttonLogin.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonLogin.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            buttonLogin.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonRegister.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            buttonRegister.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            buttonRegister.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor)
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
