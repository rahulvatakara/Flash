
//  UIStoryboardExtension.swift
//  FlashSample
//
//  Created by Rahul CK on 22/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//


import UIKit

extension UIStoryboard {
    /// return main story board
    class func main() -> UIStoryboard {
        return UIStoryboard(name: FStoryboardConstants.main, bundle: nil)
    }
}
