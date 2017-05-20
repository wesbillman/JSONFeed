//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

public struct Attachment {
    public let url: URL
    public let mimeType: String
    public let title: String?
    public let size: Int?
    public let duration: Int?

    public init(json: [AnyHashable: Any]) throws {
        guard let url = URL(string: json["url"] as? String) else {
            throw JSONFeedError.invalidURL
        }

        guard let mimeType = json["mime_type"] as? String else {
            throw JSONFeedError.invalidMimeType
        }

        self.url = url
        self.mimeType = mimeType
        self.title = json["title"] as? String
        self.size = json["size"] as? Int
        self.duration = json["duration"] as? Int
    }
}
