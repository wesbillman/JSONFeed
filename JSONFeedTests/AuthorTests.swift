//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class AuthorTests: XCTestCase {
    let url = "https://jsonfeed.org/version/1"
    let text = "Some Text"

    func testEmptyJson() {
        let author = Author(json: [:])
        XCTAssertEqual(author.name, nil)
        XCTAssertEqual(author.url, nil)
        XCTAssertEqual(author.avatar, nil)
    }

    func testValidJson() {
        let author = Author(json: ["name": text, "url": url, "avatar": url])
        XCTAssertEqual(author.name, text)
        XCTAssertEqual(author.url?.absoluteString, url)
        XCTAssertEqual(author.avatar?.absoluteString, url)
    }
}
