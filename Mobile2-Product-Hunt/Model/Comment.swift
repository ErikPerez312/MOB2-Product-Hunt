//
//  Comment.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/7/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation

struct Comments: Decodable {
    var comments: [Comment]
}

struct Comment {
    var body: String
    var votes: Int
    var userDisplayName: String
    var accountUsername: String
    
    init(body: String, votes: Int, userDisplayName: String, accountUsername: String) {
        self.body = body
        self.votes = votes
        self.userDisplayName = userDisplayName
        self.accountUsername = accountUsername
    }
}

extension Comment: Decodable {
    enum Keys: String, CodingKey {
        case body
        case votes
        case user
    }
    
    enum UserKeys: String, CodingKey {
        case displayName = "name"
        case accountUsername = "username"
    }
    
    init(from decoder: Decoder) throws {
        let commentValues = try decoder.container(keyedBy: Keys.self)
        let body = try commentValues.decode(String.self, forKey: .body)
        let votes = try commentValues.decode(Int.self, forKey: .votes)
        
        let userValues = try commentValues.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        let displayName = try userValues.decode(String.self, forKey: .displayName)
        let accountUsername = try userValues.decode(String.self, forKey: .accountUsername)
        
        self.init(body: body, votes: votes, userDisplayName: displayName, accountUsername: accountUsername)
        
    }
}







