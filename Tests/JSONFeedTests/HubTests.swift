//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class HUBTests: XCTestCase {
    let url = "https://jsonfeed.org/version/1"
    let text = "Some Text"

    func testInvalidType() {
        XCTAssertNil(Hub(json: [:]))
    }

    func testInvalidURL() {
        XCTAssertNil(Hub(json: ["type": text]))
    }

    func testValidHub() {
        let hub = Hub(json: ["type": text, "url": url])
        XCTAssertEqual(hub?.type, text)
        XCTAssertEqual(hub?.url.absoluteString, url)
    }
}
