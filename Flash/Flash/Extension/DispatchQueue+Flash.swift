//
//  DispatchQueue+Flash.swift
//  Flash
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import Foundation

extension DispatchQueue {

  func optionalAsync(_ block: @escaping () -> Void) {
    if self === DispatchQueue.main && Thread.isMainThread {
      block()
    } else {
      async {
        block()
      }
    }
  }

}
