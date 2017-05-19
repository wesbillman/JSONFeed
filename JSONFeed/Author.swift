//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

public struct Author {
    public let name: String?
    public let url: URL?
    public let avatar: URL?

    public init(json: [AnyHashable: Any]) {
        self.name = json["name"] as? String
        self.url = URL(string: json["url"] as? String)
        self.avatar = URL(string: json["avatar"] as? String)
    }
}
