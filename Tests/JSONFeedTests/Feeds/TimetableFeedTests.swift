//
//  Created by Wes Billman on 5/20/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import XCTest
@testable import JSONFeed

class TimetableFeedTests: XCTestCase {
    func testLoadingTimelineFeed() {
        guard let path = Bundle.module.path(forResource: "timetable", ofType: "json") else {
            XCTFail("json file does not exist")
            return
        }
        let feed = try? JSONFeed(data: Data(contentsOf: URL(fileURLWithPath: path)))
        XCTAssertEqual(feed?.version.absoluteString, "https://jsonfeed.org/version/1")
        XCTAssertEqual(feed?.title, "Timetable")
        XCTAssertEqual(feed?.homePage?.absoluteString, "http://timetable.manton.org/")
        XCTAssertEqual(feed?.items.count, 5)
        XCTAssertEqual(feed?.items.first?.id, "http://timetable.manton.org/2017/04/episode-45-launch-week/")
        XCTAssertEqual(feed?.items.first?.url?.absoluteString, "http://timetable.manton.org/2017/04/episode-45-launch-week/")
        XCTAssertEqual(feed?.items.first?.title, "Episode 45: Launch week")
        XCTAssertEqual(feed?.items.first?.html, "Iâ€™m rolling out early access to Micro.blog this week. I talk about how the first 2 daysÂ have gone, mistakes with TestFlight, and what to do next.")
        XCTAssertEqual(feed?.items.first?.published, ISO8601DateFormatter().date(from: "2017-04-26T01:09:45+00:00"))
        XCTAssertEqual(feed?.items.first?.attachments.count, 1)
        XCTAssertEqual(feed?.items.first?.attachments.first?.url.absoluteString, "http://timetable.manton.org/podcast-download/139/episode-45-launch-week.mp3")
        XCTAssertEqual(feed?.items.first?.attachments.first?.mimeType, "audio/mpeg")
        XCTAssertEqual(feed?.items.first?.attachments.first?.bytes, 5236920)
    }
}
