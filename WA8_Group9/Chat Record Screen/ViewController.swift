//
//  ViewController.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let chatRecordScreen = ChatRecordView()
    let db = Firestore.firestore()
    let loginScreen = LoginView()
    var chatRecordList = [ChatRecord]()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = chatRecordScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //handles the Authentication state (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //if not signed in
                self.currentUser = nil
                self.chatRecordScreen.floatingButtonAddContact.isEnabled = false
                self.chatRecordScreen.floatingButtonAddContact.isHidden = true
                //reset tableview
                self.chatRecordList.removeAll()
                self.chatRecordScreen.tableViewContacts.reloadData()
                self.setupRightBarButton(isLoggedin: false)
                self.view = self.loginScreen
                self.showLoginScreen()
                
            }else{
                // user signed in
                self.currentUser = user
                self.title = "My Chats"
                self.chatRecordScreen.labelText.text = "Hi \(user?.displayName ?? "Anonymous")!"
                self.chatRecordScreen.floatingButtonAddContact.isEnabled = true
                self.chatRecordScreen.floatingButtonAddContact.isHidden = false
                self.setupRightBarButton(isLoggedin: true)
                self.fetchUserChats(for: user?.email ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatRecordScreen.tableViewContacts.delegate = self
        chatRecordScreen.tableViewContacts.dataSource = self
        chatRecordScreen.tableViewContacts.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        view.bringSubviewToFront(chatRecordScreen.floatingButtonAddContact)
        chatRecordScreen.floatingButtonAddContact.addTarget(self, action: #selector(onFloatingButtonAddContactTapped), for: .touchUpInside)
    }
    
    func fetchUserChats(for email: String) {
        // Define a reference to the user's chats collection in Firestore
        let userChatsRef = db.collection("users").document(email).collection("chats").addSnapshotListener{
        // Fetch all documents in the user's "chats" collection
       snapshot, error in
            if let error = error {
                print("Error fetching user chats: \(error.localizedDescription)")
                return
            }
            
            // Check if snapshot contains documents
            guard let documents = snapshot?.documents else {
                print("No chats found for user.")
                return
            }
            // Initialize an array to store chat data
            var chatsArray: [String] = []
            self.chatRecordList.removeAll()
            
            for document in documents {
                let chatID = document.documentID
                chatsArray.append(chatID)

                // Retrieve last message details
                if let otherUser = document.get("other_user_name") as? String,
                   let lastMessage = document.get("last_message") as? String,
                   let otherEmail = document.get("other_user_email") as? String,
                   let lastUser = document.get("last_user") as? String {
                    let chatRecordOjb = ChatRecord(name: otherUser, email: otherEmail, lastMessage: lastMessage, lastUser: lastUser)
                    self.chatRecordList.append(chatRecordOjb)
                }
                
            }
            //print("User's chats: \(self.chatRecordList)")
            self.chatRecordScreen.tableViewContacts.reloadData()
        }
    }
    
    func showLoginScreen() {
        let loginViewController = LoginViewController()
        navigationController?.setViewControllers([loginViewController], animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    @objc func onFloatingButtonAddContactTapped() {
        let friendListViewController = FriendListViewController()
        navigationController?.pushViewController(friendListViewController, animated: true)
    }

}
