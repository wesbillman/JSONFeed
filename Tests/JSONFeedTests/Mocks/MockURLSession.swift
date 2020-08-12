//
//  Created by Wes Billman on 5/20/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    let task = MockURLSessionDataTask()
    var data: Data?
    var response: URLResponse?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return task
    }
}
