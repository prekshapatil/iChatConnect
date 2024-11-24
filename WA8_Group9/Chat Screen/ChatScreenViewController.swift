//
//  ViewController.swift
//  WA8_09_6279
//
//  Created by Hrishika Samani on 09/11/24.
//
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let chatview = ChatScreenView()
    let db = Firestore.firestore()
    let currentUserID = Auth.auth().currentUser?.uid
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserName = Auth.auth().currentUser?.displayName
    var friendName: String = "Friend"
    var friendEmail: String = "Friend Email"
    var messages = [Message]()
    var chatId: String = ""

    override func loadView() {
        view = chatview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
 
        self.chatId = HashingFunction.getHash(firstEmail: currentUserEmail ?? "", secondEmail: friendEmail)
        title = friendName

        chatview.tableView.dataSource = self
        chatview.tableView.delegate = self
        chatview.tableView.register(MessagesTableViewCell.self, forCellReuseIdentifier: "MessageCell")
        chatview.tableView.separatorStyle = .none
        chatview.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        fetchMessages()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
        
        scrollToBottom()
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return
        }
        // Adjust the bottom constraint to move the inputContainerView above the keyboard
        let keyboardHeight = keyboardFrame.height
        chatview.inputContainerBottomConstraint.constant = -keyboardHeight
        UIView.animate(withDuration: 0.3) {
            self.chatview.layoutIfNeeded()
        }
        scrollToBottom()
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        // Reset the bottom constraint to original value
        chatview.inputContainerBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.chatview.layoutIfNeeded()
        }
    }
      
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func fetchMessages() {
        // Fetch messages for this specific chatId
        db.collection("chats").document(chatId).collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                if let documents = snapshot?.documents {
                    self.messages = documents.compactMap { doc -> Message? in
                        let data = doc.data()
                        if let senderID = data["senderID"] as? String,
                           let senderName = data["senderName"] as? String,
                           let text = data["text"] as? String,
                           let timestamp = data["timestamp"] as? Timestamp {
                            return Message(senderID: senderID, senderName: senderName, text: text, timestamp: timestamp.dateValue())
                            }
                            return nil
                    }
                    self.chatview.tableView.reloadData()
                    self.scrollToBottom()
                } else {
                    print("No messages found")
                }
            }
    }
    

    @objc func sendMessage() {
        guard let messageText = chatview.messageInputField.text, !messageText.isEmpty else { return }
        guard !self.chatId.isEmpty else {
            print("Error: chatId is empty.")
            return
        }
        
        // Create a new message object
        let newMessage = Message(senderID: currentUserID ?? "unknown", senderName: currentUserName ?? "", text: messageText, timestamp: Date())
        messages.append(newMessage)
        
        // Prepare message data for Firestore
        let messageData: [String: Any] = [
            "senderID": newMessage.senderID,
            "senderName": newMessage.senderName,
            "text": newMessage.text,
            "timestamp": Timestamp(date: newMessage.timestamp)
        ]
        
        // Clear the input field immediately for quicker user feedback
        chatview.messageInputField.text = ""
        
        // Save message to Firestore
        db.collection("chats").document(self.chatId).collection("messages").addDocument(data: messageData) { error in
            if let error = error {
                print("Error sending message: \(error)")
                // Optional: Alert user of the error
            } else {
                print("Message sent successfully")
            }
        }
        
        saveChatInfo(forUser: self.currentUserEmail ?? "", withFriend: friendEmail, friendName: friendName, message: newMessage.text)
        
        // Insert new message in table view and scroll to bottom
        let newIndexPath = IndexPath(row: messages.count - 1, section: 0)
        chatview.tableView.insertRows(at: [newIndexPath], with: .automatic)
        scrollToBottom()
    }

    func saveChatInfo(forUser userEmail: String, withFriend friendEmail: String, friendName: String, message: String) {
        _ = "\(userEmail)_and_\(friendEmail)"
        var chatData: [String: Any] = [
            "date_time": Timestamp(date: Date()),
            "last_message": message,
            "last_user": userEmail,
            "other_user_email": friendEmail,
            "other_user_name": friendName
        ]
     
        // Save chat information under the current user
        db.collection("users").document(userEmail).collection("chats").document(self.chatId).setData(chatData) { error in
            if let error = error {
                print("Error saving chat for user: \(error)")
            } else {
                print("Chat saved for user \(userEmail) with friend \(friendEmail)")
            }
        }
        chatData["other_user_email"] = userEmail
        chatData["other_user_name"] = self.currentUserName
        
        // Save the same chat information under the friend’s document
        db.collection("users").document(friendEmail).collection("chats").document(self.chatId).setData(chatData) { error in
            if let error = error {
                print("Error saving chat for friend: \(error)")
            } else {
                print("Chat saved for friend \(friendEmail) with user \(userEmail)")
            }
        }
    }

    func scrollToBottom() {
        if messages.count > 0 {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            chatview.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    // MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesTableViewCell
        let message = messages[indexPath.row]
        let isCurrentUser = message.senderID == currentUserID
        cell.configure(with: message, isCurrentUser: isCurrentUser)
        return cell
    }
}
