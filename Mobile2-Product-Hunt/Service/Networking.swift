//
//  Networking.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/7/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation

class Networking {
    // Singleton
    static let shared = Networking()
    
    let baseURL = "https://api.producthunt.com/v1/"
    let session = URLSession.shared
    
    // model: Decodable  - If you want parse the data into a decodable object
    func fetch(route: Route, completioHandler: @escaping (Data) -> Void) {
        var fullURL = URL(string: baseURL.appending(route.path()))
        fullURL = fullURL?.appendingQueryParameters(route.urlParameters())
        
        var request = URLRequest(url: fullURL!)
        request.allHTTPHeaderFields = route.headers()
        
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                completioHandler(data)
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }.resume()
    }
}










