
//  URLRequestExtension.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}
extension URLRequest {
    
    public var method: HTTPMethod? {
        get {
            guard let httpMethod = self.httpMethod else { return nil }
            let method = HTTPMethod(rawValue: httpMethod)
            return method
        }
        
        set {
            self.httpMethod = newValue?.rawValue
        }
    }
}
