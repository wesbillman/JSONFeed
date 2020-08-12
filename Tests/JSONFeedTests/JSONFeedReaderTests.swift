//
//  Created by Wes Billman on 5/20/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class JSONFeedReaderTests: XCTestCase {
    enum TestError: Error {
        case sessionError
    }

    private let url = "https://jsonfeed.org/version/1"
    private let text = "Some Text"

    private var session: MockURLSession!
    private var subject: JSONFeedReader!

    var validData: Data {
        let json = ["version": url, "title": text]
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            return Data()
        }
        return data
    }

    override func setUp() {
        super.setUp()
        session = MockURLSession()
        subject = JSONFeedReader(session: session)
    }

    func testInvalidURLString() {
        var resultFeed: JSONFeed? = nil
        var resultError: Error? = nil
        let nilString: String? = nil

        subject.read(string: "bogus\\\(String(describing: nilString))") { (feed, error) in
            resultFeed = feed
            resultError = error
        }
        XCTAssert(!session.task.resumed)
        XCTAssertEqual(resultError as? JSONFeedReaderError, JSONFeedReaderError.invalidRequestString)
        XCTAssertNil(resultFeed)
    }

    func testSessionError() {
        session.error = TestError.sessionError
        var resultFeed: JSONFeed? = nil
        var resultError: Error? = nil

        subject.read(string: "example.com") { (feed, error) in
            resultFeed = feed
            resultError = error
        }
        XCTAssert(session.task.resumed)
        XCTAssertEqual(resultError as? TestError, TestError.sessionError)
        XCTAssertNil(resultFeed)
    }

    func testNilData() {
        session.data = nil
        var resultFeed: JSONFeed? = nil
        var resultError: Error? = nil

        subject.read(string: "example.com") { (feed, error) in
            resultFeed = feed
            resultError = error
        }
        XCTAssert(session.task.resumed)
        XCTAssertEqual(resultError as? JSONFeedReaderError, JSONFeedReaderError.emptyResponseData)
        XCTAssertNil(resultFeed)
    }

    func testInvalidData() {
        guard let data = "bogus".data(using: .utf8) else {
            XCTFail()
            return
        }
        session.data = data
        var resultFeed: JSONFeed? = nil
        var resultError: Error? = nil

        subject.read(string: "example.com") { (feed, error) in
            resultFeed = feed
            resultError = error
        }
        XCTAssert(session.task.resumed)
        XCTAssertEqual(resultError as? JSONFeedError, JSONFeedError.invalidData)
        XCTAssertNil(resultFeed)
    }

    func testReadingFeedURL() {
        session.data = validData
        var resultFeed: JSONFeed? = nil
        var resultError: Error? = nil

        guard let feedUrl = URL(string: "example.com") else {
            XCTFail("unable to create url")
            return
        }

        subject.read(url: feedUrl) { (feed, error) in
            resultFeed = feed
            resultError = error
        }
        XCTAssert(session.task.resumed)
        XCTAssertEqual(resultFeed?.version.absoluteString, url)
        XCTAssertEqual(resultFeed?.title, text)
        XCTAssertNil(resultError)
    }

    func testReadingFeedURLString() {
        session.data = validData
        var resultFeed: JSONFeed? = nil
        var resultError: Error? = nil

        subject.read(string: "example.com") { (feed, error) in
            resultFeed = feed
            resultError = error
        }
        XCTAssert(session.task.resumed)
        XCTAssertEqual(resultFeed?.version.absoluteString, url)
        XCTAssertEqual(resultFeed?.title, text)
        XCTAssertNil(resultError)
    }
}
