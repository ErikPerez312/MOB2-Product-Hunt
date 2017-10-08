//
//  QueryParameters.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/8/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation

//Code From Elmer Astudillo. Git repo: https://github.com/elmerastudillo/Product-Hunt-API-Project
extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
    // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}


extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}
