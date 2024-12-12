//
//  FriendListViewController.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FriendListViewController: UIViewController {
    
    let friendListScreen = FriendListView()
    var friendList = [Friend]()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = friendListScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Friends"
        friendListScreen.tableViewFriends.delegate = self
        friendListScreen.tableViewFriends.dataSource = self
        friendListScreen.tableViewFriends.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchFriends()
    }
    
    func fetchFriends() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            print("user not found")
            return
        }
        database.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("error fetching friends: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("no friends found")
                return
            }
            self.friendList = documents.compactMap { document in
                let data = document.data()
                let email = data["email"] as? String ?? ""
                
                guard let name = data["name"] as? String,
                      email.lowercased() != currentUserEmail else {
                    return nil
                }
                return Friend(name: name, email: email)
            }
            DispatchQueue.main.async {
                self.friendListScreen.tableViewFriends.reloadData()
            }
        }
    }

}
