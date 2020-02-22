
//  NSObjectExtension.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import UIKit

extension NSObject {

    class var className: String {
        return String(describing: self)
    }
}
