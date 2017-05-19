//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class JSONFeedTests: XCTestCase {
    func testShouldThrowInvalidVersion() {
        XCTAssertThrowsError(try JSONFeed(json: [:])) { error in
            XCTAssertEqual(error as? JSONFeedError, JSONFeedError.invalidVersion)
        }
    }
}
