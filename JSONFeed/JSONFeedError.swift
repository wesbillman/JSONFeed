//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

public enum JSONFeedError: Error {
    case notAJSONFeed
    case invalidVersion
    case invalidTitle
    case invalidData
    case invalidJSON
    case invalidString
}
