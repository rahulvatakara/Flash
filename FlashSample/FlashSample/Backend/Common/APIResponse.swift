
//  APIResponse.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import Foundation

enum APIResponse<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
