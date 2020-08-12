//
//  Created by Wes Billman on 5/20/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class SimpleFeedTests: XCTestCase {
    func testSimpleFeedData() {
        guard let path = Bundle.module.path(forResource: "simple", ofType: "json") else {
            XCTFail("json file does not exist")
            return
        }
        let feed = try? JSONFeed(data: Data(contentsOf: URL(fileURLWithPath: path)))
        XCTAssertEqual(feed?.version.absoluteString, "https://jsonfeed.org/version/1")
        XCTAssertEqual(feed?.title, "My Example Feed")
        XCTAssertEqual(feed?.homePage?.absoluteString, "https://example.org/")
        XCTAssertEqual(feed?.feed?.absoluteString, "https://example.org/feed.json")
        XCTAssertEqual(feed?.items.count, 2)
        XCTAssertEqual(feed?.items.first?.id, "2")
        XCTAssertEqual(feed?.items.first?.url?.absoluteString, "https://example.org/second-item")
        XCTAssertEqual(feed?.items.first?.text, "This is a second item.")
    }

    func testSimpleFeedString() {
        guard let path = Bundle.module.path(forResource: "simple", ofType: "json") else {
            XCTFail("json file does not exist")
            return
        }
        guard let string = try? String(contentsOf: URL(fileURLWithPath: path)) else {
            XCTFail("json file is not text")
            return
        }
        let feed = try? JSONFeed(string: string)
        XCTAssertEqual(feed?.version.absoluteString, "https://jsonfeed.org/version/1")
        XCTAssertEqual(feed?.title, "My Example Feed")
        XCTAssertEqual(feed?.homePage?.absoluteString, "https://example.org/")
        XCTAssertEqual(feed?.feed?.absoluteString, "https://example.org/feed.json")
        XCTAssertEqual(feed?.items.count, 2)
        XCTAssertEqual(feed?.items.first?.id, "2")
        XCTAssertEqual(feed?.items.first?.url?.absoluteString, "https://example.org/second-item")
        XCTAssertEqual(feed?.items.first?.text, "This is a second item.")
    }
}
