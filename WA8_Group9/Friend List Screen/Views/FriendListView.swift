//
//  FriendListView.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import UIKit

class FriendListView: UIView {
    
    var labelText: UILabel!
    var tableViewFriends: UITableView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabelText()
        setupTableViewFriends()
        initConstraints()
    }
        
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewFriends(){
        tableViewFriends = UITableView()
        tableViewFriends.register(FriendsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewFriends)
        tableViewFriends.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewFriends)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            tableViewFriends.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 10),
            tableViewFriends.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableViewFriends.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableViewFriends.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
