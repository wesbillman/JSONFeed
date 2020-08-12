//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

public class JSONFeed {
    public let version: URL
    public let title: String
    public let homePage: URL?
    public let feed: URL?
    public let description: String?
    public let userComment: String?
    public let next: URL?
    public let icon: URL?
    public let favicon: URL?
    public let author: Author?
    public let hasExpired: Bool
    public let hubs: [Hub]?
    public let items: [Item]

    public init(json: [AnyHashable: Any]) throws {
        guard let version = URL(string: json["version"] as? String) else {
            throw JSONFeedError.invalidVersion
        }

        guard let title = json["title"] as? String else {
            throw JSONFeedError.invalidTitle
        }

        self.version = version
        self.title = title
        self.homePage = URL(string: json["home_page_url"] as? String)
        self.feed = URL(string: json["feed_url"] as? String)
        self.description = json["description"] as? String
        self.userComment = json["user_comment"] as? String
        self.next = URL(string: json["next_url"] as? String)
        self.icon = URL(string: json["icon"] as? String)
        self.favicon = URL(string: json["favicon"] as? String)

        if let authorJSON = json["author"] as? [AnyHashable: Any] {
            self.author = Author(json: authorJSON)
        } else {
            self.author = nil
        }

        if let hubsJSON = json["hubs"] as? [[AnyHashable: Any]] {
//            self.hubs = hubsJSON.flatMap(Hub.init)
            self.hubs = hubsJSON.compactMap { Hub(json: $0) }
        } else {
            self.hubs = nil
        }

        if let itemsJSON = json["items"] as? [[AnyHashable: Any]] {
            self.items = itemsJSON.compactMap { try? Item(json: $0) }
        } else {
            self.items = []
        }

        self.hasExpired = json["expired"] as? Bool ?? false
    }

    public convenience init(data: Data) throws {
        let result = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let json = result as? [AnyHashable: Any] else {
            throw JSONFeedError.invalidData
        }
        try self.init(json: json)
    }

    public convenience init(string: String) throws {
        guard let data = string.data(using: .utf8), !data.isEmpty else {
            throw JSONFeedError.invalidString
        }
        try self.init(data: data)
    }
}
