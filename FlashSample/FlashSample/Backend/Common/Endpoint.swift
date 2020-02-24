
//  EndPoints.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    
    var apiKey: String {
        return ""
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

enum GTFeed {
    case home
}

extension GTFeed: Endpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var base: String {
        return "https://pastebin.com"
    }
    
    var path: String {
        switch self {
            
        case .home:
            return "/raw/1WcGvnm5"
    }
}
}

