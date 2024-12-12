//
//  Friend.swift
//  WA8_Group9
//
//  Created by Karyn T on 11/10/24.
//

import Foundation

struct Friend: Codable{
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
