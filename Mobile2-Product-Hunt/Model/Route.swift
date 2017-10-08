//
//  Route.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/7/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation

enum Route {
    case post
    case comments(postId: Int)
    
    func path() -> String {
        switch self {
        case .post: return "posts"
        case .comments: return "comments"
        }
    }
    
    func urlParameters() -> [String : String] {
        let date = String(describing: Date())
        
        switch self {
        case .post:
            let parameters = ["search[featured]": "true",
                              "scope": "public",
                              "created_at": date,
                              "per_page": "20"]
            return parameters
        case .comments(let postID):
            let parameters = ["search[post_id]": String(describing: postID),
                              "scope": "public",
                              "created_at": date,
                              "per_page": "20"]
            return parameters
        }
    }
    
    func headers() -> [String: String] {
        // Former token: ae3328ef2b38c2fb625fe7d44fa7904810488646fb4cbf1ed9c86d61570b1090
        let token = "fa94feed5389a55a270a7ca766ceaa157ad877649f91ff6d101b6e6e2994d21a"
        let headers = ["Authorization" : "Bearer \(token)",
                          "Accept": "application/json",
                          "Content-Type": "application/json",
                          "Host": "api.producthunt.com"]
        return headers
    }
    
    // If http body is needed for Post request
    func body() -> Data?{
        switch self {
        case .post: return Data()
        default: return nil
        }
    }
}






