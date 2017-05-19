//
//  Created by Wes Billman on 5/19/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

extension URL {
    init?(string: String?) {
        guard let string = string else {
            return nil
        }
        self.init(string: string)
    }
}
