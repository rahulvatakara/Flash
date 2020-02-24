//
//  FlashTests.swift
//  FlashTests
//
//  Created by Rahul CK on 20/02/20.
//  Copyright © 2020 Mindvalley. All rights reserved.
//

import XCTest
@testable import Flash

class FlashTests: XCTestCase {
    
    private let url: URL = URL(string: "https://pbs.twimg.com/profile_images/523266184301404161/SxoLhsIi.jpeg")!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDownload() {
       let downloader = Downloader()

       let expectation = self.expectation(description: #function)

       let token = downloader.download(self.url) { data in
         XCTAssertNotNil(data)
         expectation.fulfill()
       }

       waitForExpectations(timeout: 5, handler: nil)
       XCTAssertNotNil(token)
     }

     func testMultipleDownloads() {
       let downloader = Downloader()

       let firstExpectation = expectation(description: "first")

       let url1 = url
       _ = downloader.download(url1) { data in
         XCTAssertNotNil(data)
         firstExpectation.fulfill()
       }

       let secondExpectation = expectation(description: "second")
       
       let url2 = url
       _ = downloader.download(url2) { data in
         XCTAssertNotNil(data)
         secondExpectation.fulfill()
       }

       waitForExpectations(timeout: 5, handler: nil)
     }

     func testSynchronousMultipleDownloadsOfSameURL() {
       let downloader = Downloader()

       let expectation = self.expectation(description: #function)

       _ = downloader.download(self.url) { data in
         XCTAssertNotNil(data)
       }
       _ = downloader.download(self.url) { data in
         XCTAssertNotNil(data)
         expectation.fulfill()
       }

       waitForExpectations(timeout: 5, handler: nil)
     }

     func testCancel() {
       let downloader = Downloader()

       let expectation = self.expectation(description: #function)

       let token = downloader.download(url) { data in
         XCTAssertNil(data)
         expectation.fulfill()
       }
       downloader.cancel(withToken: token)

       waitForExpectations(timeout: 5, handler: nil)
     }


}
