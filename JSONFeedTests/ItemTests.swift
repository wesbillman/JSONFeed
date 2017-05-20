//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class ItemTests: XCTestCase {
    let url = "https://jsonfeed.org/version/1"
    let text = "Some Text"
    let date = "2017-04-26T01:09:45+00:00"

    func testInvalidURL() {
        XCTAssertThrowsError(try Item(json: [:])) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidID)
        }
    }

    func testValidAttachment() {
        let json: [String : Any] = [
            "id": text,
            "url": url,
            "external_url": url,
            "title": text,
            "content_text": text,
            "content_html": text,
            "summary": text,
            "image": url,
            "banner_image": url,
            "date_published": date,
            "date_modified": date,
            "author": ["name": text, "url": url, "avatar": url],
            "tags": ["one", "two"],
            "attachments": [["url": url, "mime_type": text]]
            ]
        let item = try? Item(json: json)
        XCTAssertEqual(item?.id, text)
        XCTAssertEqual(item?.url?.absoluteString, url)
        XCTAssertEqual(item?.external?.absoluteString, url)
        XCTAssertEqual(item?.title, text)
        XCTAssertEqual(item?.text, text)
        XCTAssertEqual(item?.html, text)
        XCTAssertEqual(item?.image?.absoluteString, url)
        XCTAssertEqual(item?.banner?.absoluteString, url)
        XCTAssertEqual(item?.published, ISO8601DateFormatter().date(from: date))
        XCTAssertEqual(item?.modified, ISO8601DateFormatter().date(from: date))
        XCTAssertEqual(item?.author?.name, text)
        XCTAssertEqual(item?.author?.url?.absoluteString, url)
        XCTAssertEqual(item?.author?.avatar?.absoluteString, url)
        XCTAssertEqual(item?.tags?.count, 2)
        XCTAssertEqual(item?.tags?[0], "one")
        XCTAssertEqual(item?.tags?[1], "two")
        XCTAssertEqual(item?.attachments.count, 1)
        XCTAssertEqual(item?.attachments.first?.url.absoluteString, url)
        XCTAssertEqual(item?.attachments.first?.mimeType, text)
    }
}
