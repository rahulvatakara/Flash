//
//  Flash.swift
//  Flash
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//
import UIKit

public typealias ImageDownloadCompletion = (UIImage?) -> Void
public typealias DataDownloadCompletion = (Data?) -> Void

public final class Flash {

  /// The shared instance of Flash
  public static let shared = Flash()
  
  public let cache: FlashCache
  public let downloader: Downloader
  
  /// Initialize a new instance of Flash.
  ///
  /// - Parameter cache: The cache to use. Uses the `default` instance if nothing is passed
  /// - Parameter downloader: The downloader to use. Users the `default` instance if nothing is passed
  public init(cache: FlashCache = .default, downloader: Downloader = .default) {
    self.cache = cache
    self.downloader = downloader
  }

  /// Download or retrieve an image from cache
  ///
  /// - Parameters:
  ///     - url: The URL to load an image from
  ///     - progress: An optional closure to track the download progress
  ///     - completion: The closure to call once the download is done. The completion is called on a background thread
  /// - Returns: An optional download token `UUID` – if the image can be fetched from cache there won't be a token
  @discardableResult
  public func image(with url: URL,
                    progress: DownloadProgress? = nil,
                    completion: @escaping ImageDownloadCompletion) -> UUID? {
    return fetchImage(with: url, progress: progress, completion: completion)
  }

  /// Download or retrieve an data from cache
  ///
  /// - Parameters:
  ///     - url: The URL to load (image) data from
  ///     - progress: An optional closure to track the download progress
  ///     - completion: The closure to call once the download is done. The completion is called on a background thread
  /// - Returns: An optional download token `UUID` – if the data can be fetched from cache there won't be a token
  @discardableResult
  public func data(with url: URL,
                   progress: DownloadProgress? = nil,
                   completion: @escaping DataDownloadCompletion) -> UUID? {
    fetchData(with: url, progress: progress) { data, _ in
      completion(data)
    }
  }

  /// Pre-warms the image cache. Downloads the image if needed or loads it into memory.
  ///
  /// - Parameter url: The URL to load an image from
  public func preWarmCache(for url: URL) {
    _ = fetchImage(with: url, progress: nil, completion: nil)
  }

  /// Cancel a running download
  ///
  /// - Parameter token: The token identifier of the the download
  public func cancelDownload(withToken token: UUID) {
    downloader.cancel(withToken: token)
  }

  private func fetchImage(with url: URL,
                          progress: DownloadProgress?,
                          completion: ImageDownloadCompletion?) -> UUID? {
    fetchData(with: url, progress: progress) { [weak self] data, cacheType in
      guard let self = self, let data = data, let image = UIImage(data: data) else {
        completion?(nil)
        return
      }

      if cacheType == .none {
        DispatchQueue.global(qos: .userInitiated).async {
          let cacheData = image.pngData()
          self.cache.store(data: cacheData, forKey: url.absoluteString)
            DispatchQueue.main.async {
                completion?(image)
            }
        }
      } else {
        completion?(image)
      }
    }
  }

  private func fetchData(with url: URL,
                         progress: DownloadProgress?,
                         completion: ((Data?, CacheType) -> Void)?) -> UUID? {
    let key = url.absoluteString
    var token: UUID?
    cache.retrieveData(forKey: key) { [weak self] data, cacheType in
      guard let data = data else {
        let downloadToken = self?.downloader.download(url, progress: progress, completion: { data in
          guard let self = self, let data = data else {
            completion?(nil, cacheType)
            return
          }
          self.cache.store(data: data, forKey: url.absoluteString)
          completion?(data, cacheType)
        })
        token = downloadToken
        return
      }
      completion?(data, cacheType)
    }
    return token
  }

}

