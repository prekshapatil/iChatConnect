//
//  ChatRecord.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import Foundation

struct ChatRecord: Codable{
    var name: String
    var email: String
    var lastMessage: String
    var lastUser: String
    
    init(name: String, email: String, lastMessage: String, lastUser: String) {
        self.name = name
        self.email = email
        self.lastMessage = lastMessage
        self.lastUser = lastUser
    }
}
