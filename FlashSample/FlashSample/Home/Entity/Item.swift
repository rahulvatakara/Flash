//
//
//  Item.swift
//  FlashSample
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let id:String?
    let user:User?

}

struct User: Decodable {
    let name:String?
    let username:String?
    let profile_image: ProfileImage
}

struct ProfileImage: Decodable {
    let medium:String?
}
