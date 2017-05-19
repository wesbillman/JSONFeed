//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class URLExtensionsTests: XCTestCase {
    func testNilString() {
        XCTAssertEqual(URL(string: nil), nil)
    }

    func testValidURL() {
        let string: String? = "http://example.com"
        let url = URL(string: string)
        XCTAssertEqual(url?.absoluteString, string)
    }
}
