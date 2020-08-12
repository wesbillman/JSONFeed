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

    func testInvalidData() {
        guard let data = "bogus".data(using: .utf8) else {
            XCTFail()
            return
        }
        XCTAssertThrowsError(try JSONFeed(data: data)) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidData)
        }
    }

    func testInvalidString() {
        XCTAssertThrowsError(try JSONFeed(string: "")) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidString)
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
            "hubs": [["type": text, "url": url]],
            "items": [["id": text]]
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
        XCTAssertEqual(feed?.items.count, 1)
        XCTAssertEqual(feed?.items.first?.id, text)
    }

    func testFeedFromData() {
        let json = ["version": url, "title": text]
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            XCTFail()
            return
        }

        let feed = try? JSONFeed(data: data)
        XCTAssertEqual(feed?.version.absoluteString, url)
        XCTAssertEqual(feed?.title, text)
    }

    func testFeedFromString() {
        let string = "{\"version\": \"\(url)\", \"title\": \"\(text)\"}"

        let feed = try? JSONFeed(string: string)
        XCTAssertEqual(feed?.version.absoluteString, url)
        XCTAssertEqual(feed?.title, text)
    }
}
