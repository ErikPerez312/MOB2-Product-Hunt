//
//  Post.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/7/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation

struct PostList: Decodable {
    let posts: [Post]
}

struct Post {
    //Propertes
    var id: Int
    var name: String
    var tagline: String
    var votes: Int
    var thumbnailURL: String
    
    init(id: Int, name: String, tagline: String, votes: Int, thumbnailURL: String) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.votes = votes
        self.thumbnailURL = thumbnailURL
    }
}

extension Post: Decodable {
    enum Keys: String, CodingKey {
        case id
        case name
        case tagline
        case votes = "votes_count"
        case thumbnail
    }
    enum ThumbnailKeys: String, CodingKey {
        case url = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let postValues = try decoder.container(keyedBy: Keys.self)
        let id = try postValues.decode(Int.self, forKey: .id)
        let name = try postValues.decode(String.self, forKey: .name)
        let tagline = try postValues.decode(String.self, forKey: .tagline)
        let votes = try postValues.decode(Int.self, forKey: .votes)
        
        let thumbnailValues = try postValues.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
        let thumbnailURL = try thumbnailValues.decode(String.self, forKey: .url)
        
        self.init(id: id, name: name, tagline: tagline, votes: votes, thumbnailURL: thumbnailURL)
    }
}











