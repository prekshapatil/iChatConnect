//
//  ChatRecordTableViewManager.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import Foundation
import UIKit
import FirebaseAuth

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRecordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var sender = ""
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatRecords, for: indexPath) as! ChatRecordTableViewCell
        if chatRecordList[indexPath.row].lastUser == Auth.auth().currentUser?.email {
            sender = "You: "
        }
        
        
        cell.labelName.text = chatRecordList[indexPath.row].name
        cell.labelMessage.text = sender+chatRecordList[indexPath.row].lastMessage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatScreenViewController = ChatScreenViewController()
        chatScreenViewController.friendEmail = chatRecordList[indexPath.row].email
        chatScreenViewController.friendName = chatRecordList[indexPath.row].name
        navigationController?.pushViewController(chatScreenViewController, animated: true)
        }
}
