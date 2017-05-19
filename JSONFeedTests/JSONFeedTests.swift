//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class JSONFeedTests: XCTestCase {
    let version = "https://jsonfeed.org/version/1"
    let title = "Test Title"
    func testInvalidVersion() {
        XCTAssertThrowsError(try JSONFeed(json: [:])) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidVersion)
        }
    }

    func testInvalidTitle() {
        let json = ["version": version]
        XCTAssertThrowsError(try JSONFeed(json: json)) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidTitle)
        }
    }

    func testEmptyFeed() {
        let json = ["version": version, "title": title]
        let feed = try? JSONFeed(json: json)
        XCTAssertEqual(feed?.version.absoluteString, version)
        XCTAssertEqual(feed?.title, title)
    }
}
