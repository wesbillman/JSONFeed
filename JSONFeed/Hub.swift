//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

public struct Hub {
    public let type: String
    public let url: URL

    public init?(json: [AnyHashable: Any]) {
        guard let type = json["type"] as? String else {
            return nil
        }

        guard let url = URL(string: json["url"] as? String) else {
            return nil
        }

        self.type = type
        self.url = url
    }
}
