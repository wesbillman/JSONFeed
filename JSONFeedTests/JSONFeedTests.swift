//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class JSONFeedTests: XCTestCase {
    let url = "https://jsonfeed.org/version/1"
    let text = "Some Text"

    func testInvalidVersion() {
        XCTAssertThrowsError(try JSONFeed(json: [:])) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidVersion)
        }
    }

    func testInvalidTitle() {
        let json = ["version": url]
        XCTAssertThrowsError(try JSONFeed(json: json)) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidTitle)
        }
    }

    func testEmptyFeed() {
        let json = ["version": url, "title": text]
        let feed = try? JSONFeed(json: json)
        XCTAssertEqual(feed?.version.absoluteString, url)
        XCTAssertEqual(feed?.title, text)
    }

    func testFullyPopulatedFeed() {
        let json: [String : Any] = [
            "version": url,
            "title": text,
            "home_page_url": url,
            "feed_url": url,
            "description": text,
            "user_comment": text,
            "next_url": url,
            "icon": url,
            "favicon": url,
            "author": ["name": text, "url": url, "avatar": url],
            "hubs": [["type": text, "url": url]]
        ]
        let feed = try? JSONFeed(json: json)
        XCTAssertEqual(feed?.version.absoluteString, url)
        XCTAssertEqual(feed?.title, text)
        XCTAssertEqual(feed?.homePage?.absoluteString, url)
        XCTAssertEqual(feed?.feed?.absoluteString, url)
        XCTAssertEqual(feed?.description, text)
        XCTAssertEqual(feed?.userComment, text)
        XCTAssertEqual(feed?.next?.absoluteString, url)
        XCTAssertEqual(feed?.icon?.absoluteString, url)
        XCTAssertEqual(feed?.favicon?.absoluteString, url)
        XCTAssertEqual(feed?.author?.name, text)
        XCTAssertEqual(feed?.author?.url?.absoluteString, url)
        XCTAssertEqual(feed?.author?.avatar?.absoluteString, url)
        XCTAssertEqual(feed?.hubs?.count, 1)
        XCTAssertEqual(feed?.hubs?.first?.type, text)
        XCTAssertEqual(feed?.hubs?.first?.url.absoluteString, url)
    }
}
