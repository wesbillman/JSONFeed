//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

public struct Item {
    public let id: String
    public let url: URL?
    public let external: URL?
    public let title: String?
    public let text: String?
    public let html: String?
    public let summary: String?
    public let image: URL?
    public let banner: URL?
    public let published: Date
    public let modified: Date?
    public let author: Author?
    public let tags: [String]?
    public let attachments: [Attachment]

    public init(json: [AnyHashable: Any]) throws {
        guard let id = json["id"] as? String else {
            throw JSONFeedError.invalidID
        }

        self.id = id
        self.url = URL(string: json["url"] as? String)
        self.external = URL(string: json["external_url"] as? String)
        self.title = json["title"] as? String
        self.text = json["content_text"] as? String
        self.html = json["content_html"] as? String
        self.summary = json["summary"] as? String
        self.image = URL(string: json["image"] as? String)
        self.banner = URL(string: json["banner_image"] as? String)

        if let dateString = json["date_published"] as? String, let date = ISO8601DateFormatter().date(from: dateString) {
            self.published = date
        } else {
            self.published = Date()
        }

        if let dateString = json["date_modified"] as? String, let date = ISO8601DateFormatter().date(from: dateString) {
            self.modified = date
        } else {
            self.modified = Date()
        }

        if let authorJSON = json["author"] as? [AnyHashable: Any] {
            self.author = Author(json: authorJSON)
        } else {
            self.author = nil
        }

        if let tagsJSON = json["tags"] as? [String] {
            self.tags = tagsJSON
        } else {
            self.tags = nil
        }

        if let attachmentsJSON = json["attachments"] as? [[AnyHashable: Any]] {
            self.attachments = attachmentsJSON.compactMap { try? Attachment(json: $0) }
        } else {
            self.attachments = []
        }
    }
}
