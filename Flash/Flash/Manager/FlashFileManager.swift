//
//  FlashFileManager.swift
//  Flash
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import Foundation

public protocol FlashFileManager {
  
  func fileContents(at url: URL) throws -> Data
  
  func fileExists(atPath path: String) -> Bool
}

extension FileManager: FlashFileManager {
  
  public func fileContents(at url: URL) throws -> Data {
    try Data(contentsOf: url, options: .mappedIfSafe)
  }
  
}
