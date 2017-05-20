//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class AttachmentTests: XCTestCase {
    let url = "https://jsonfeed.org/version/1"
    let text = "Some Text"
    let size = 120
    let duration = 60

    func testInvalidURL() {
        XCTAssertThrowsError(try Attachment(json: [:])) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidURL)
        }
    }

    func testInvalidMimeType() {
        XCTAssertThrowsError(try Attachment(json: ["url": url])) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidMimeType)
        }
    }

    func testValidAttachment() {
        let json: [String : Any] = [
            "url": url,
            "mime_type": text,
            "title": text,
            "size_in_bytes": size,
            "duration_in_seconds": duration,
        ]
        let attachment = try? Attachment(json: json)
        XCTAssertEqual(attachment?.url.absoluteString, url)
        XCTAssertEqual(attachment?.mimeType, text)
        XCTAssertEqual(attachment?.title, text)
        XCTAssertEqual(attachment?.bytes, size)
        XCTAssertEqual(attachment?.seconds, duration)
    }
}
