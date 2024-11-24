//
//  ChatScreenView.swift
//  WA8_09_6279
//
//  Created by Preksha Patil on 09/11/24.
//

import UIKit

class ChatScreenView: UIView {
    
    let tableView = UITableView()
    let messageInputField = UITextField()
    let sendButton = UIButton(type: .system)
    let inputContainerView = UIView()
    
    var inputContainerBottomConstraint: NSLayoutConstraint!


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white

        // Setup TableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(inputContainerView)
        
        messageInputField.placeholder = "Type a message..."
        messageInputField.borderStyle = .none
        messageInputField.translatesAutoresizingMaskIntoConstraints = false
        messageInputField.layer.cornerRadius = 14
        messageInputField.clipsToBounds = true
        messageInputField.layer.borderWidth = 0.5
        messageInputField.layer.borderColor = UIColor.systemGray2.cgColor
        // Add padding to the left of the text field
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: messageInputField.frame.height))
        messageInputField.leftView = paddingView
        messageInputField.rightView = paddingView
        messageInputField.leftViewMode = .always
        messageInputField.rightViewMode = .always
        
        inputContainerView.addSubview(messageInputField)

        // Setup Send Button
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(sendButton)
    }

    private func setupConstraints() {
        inputContainerBottomConstraint = inputContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -8),
            
            // Input Container Constraints
            inputContainerBottomConstraint,
            inputContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            inputContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            inputContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            // Message Input Field Constraints
            messageInputField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10),
            messageInputField.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
            messageInputField.heightAnchor.constraint(equalToConstant: 40),

            // Send Button Constraints
            sendButton.leadingAnchor.constraint(equalTo: messageInputField.trailingAnchor, constant: 4),
            sendButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
