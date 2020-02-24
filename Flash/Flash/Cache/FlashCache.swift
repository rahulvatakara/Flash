//
//  FlashCache.swift
//  Flash
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//
import UIKit

public enum CacheType {
  case none, memory, disk
}

/// The class responsible for caching images. Images will be cached both in memory and on disk.
public final class FlashCache {

  private static let prefix = "com.mindvalley.Cache."

  /// The default `Cache` singleton
  public static let `default` = FlashCache(name: "default")
  private let memory: MemoryCache<String, Data>

  /// - Parameters:
  ///   - name: The name of the cache. Used to construct a unique cache path
  ///   - backingStore: The backing store – defaults to `FileManager.default`
  public init(name: String, backingStore: FlashFileManager = FileManager.default) {
    let cacheName = Self.prefix + name
    memory = MemoryCache<String, Data>(name: cacheName)
  }

  /// Stores an image in the cache. Images will be added to both memory and disk.
  ///
  /// - Parameters:
  ///     - data: The image data to cache
  ///     - key: The unique identifier of the image
  ///     - completion: An optional closure called once the image has been persisted to disk. Runs on the main queue.
  public func store(data: Data? = nil, forKey key: String,
                    completion: (() -> Void)? = nil) {
    storeToMemory(data: data, forKey: key)
  }

  @discardableResult
  private func storeToMemory(data: Data?, forKey key: String) -> String {
    let cacheKey = makeCacheKey(key)
    memory[cacheKey] = data
    return cacheKey
  }

  private func makeCacheKey(_ key: String) -> String {
    let fileSafeKey = key.replacingOccurrences(of: "/", with: "-")
    return fileSafeKey
  }

  /// Retrieve an image from cache. Will look in both memory and on disk. When the image is only available on disk
  /// it will be stored again in memory for faster access.
  ///
  /// - Parameters
  ///     - key: The unique identifier of the image
  ///     - completion: The completion called once the image has been retrieved from the cache
  public func retrieveImage(forKey key: String, completion: (UIImage?, CacheType) -> Void) {
    retrieveData(forKey: key) { data, cacheType in
      guard let data = data else {
        completion(nil, cacheType)
        return
      }
      completion(UIImage(data: data), cacheType)
    }
  }

  /// Retrieve raw `Data` from cache. Will look in both memory and on disk. When the data is only available on disk
  /// it will be stored again in memory for faster access.
  ///
  /// - Parameters
  ///     - key: The unique identifier of the data
  ///     - completion: The completion called once the image has been retrieved from the cache
  public func retrieveData(forKey key: String, completion: (Data?, CacheType) -> Void) {
    let cacheKey = makeCacheKey(key)
    if let data = memory[cacheKey] {
      completion(data, .memory)
      return
    }
    completion(nil, .none)
  }

  public func clearMemory() {
    memory.clear()
  }
  
}

