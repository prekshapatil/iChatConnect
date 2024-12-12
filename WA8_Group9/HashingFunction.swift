//
//  HashingFunction.swift
//  WA8_09_6279
//
//  Created by Hrishika Samani on 11/10/24.
//

struct HashingFunction {

    static func getHash(firstEmail: String, secondEmail: String) -> String {
        
        // Sort the emails alphabetically to ensure the same hash regardless of the order
        let emails = [firstEmail.lowercased(), secondEmail.lowercased()].sorted()
        let combinedString = emails.joined(separator: "_")
        
        // Create a simple hash by using Swift's built-in hashing mechanism
        let hashValue = UInt64(bitPattern: Int64(combinedString.hash))
        
        // Convert the hash value to a string
        return String(hashValue)
    }
}
