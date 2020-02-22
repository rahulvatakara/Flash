
//  GTAPIManager.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import Foundation

class FSAPIManager: BaseAPIManager {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    /**
     Fetch home data
     */
    func fetchHomeData(completion: @escaping (APIResponse<[Item]?, APIError>) -> Void) {
        
        let endpoint = GTFeed.home
        var request = endpoint.request
        request.method = HTTPMethod.get
        print(request.method ?? "")
        fetch(with: request, decode: { json -> [Item]? in
            guard let itemFeedResult = json as? [Item] else { return  nil }
            return itemFeedResult
        }, completion: completion)
    }
}
