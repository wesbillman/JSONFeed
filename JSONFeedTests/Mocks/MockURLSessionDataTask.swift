//
//  Created by Wes Billman on 5/20/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private(set) var resumed = false
    override func resume() {
        resumed = true
    }
}
