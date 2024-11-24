//
//  FriendsTableViewManager.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import Foundation
import UIKit

extension FriendListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriends, for: indexPath) as! FriendsTableViewCell
        cell.labelName.text = friendList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatScreenVC = ChatScreenViewController()
    
        chatScreenVC.friendName = friendList[indexPath.row].name
        chatScreenVC.friendEmail = friendList[indexPath.row].email

        navigationController?.pushViewController(chatScreenVC, animated: true)
    }
}
