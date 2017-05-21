//
//  Created by Wes Billman on 5/20/17.
//  Copyright © 2017 wesbillman. All rights reserved.
//

import Foundation

public enum JSONFeedReaderError: Error {
    case invalidRequestString
    case emptyResponseData
}

public class JSONFeedReader {
    private let session: URLSession

    public init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }

    public func read(url: URL, complete: @escaping (JSONFeed?, Error?) -> Void) {
        let task = session.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            if let error = error {
                complete(nil, error)
                return
            }
            guard let data = data else {
                complete(nil, JSONFeedReaderError.emptyResponseData)
                return
            }
            do {
                let feed = try JSONFeed(data: data)
                complete(feed, nil)
            } catch {
                complete(nil, error)
            }
        }
        task.resume()
    }

    public func read(string: String, complete: @escaping (JSONFeed?, Error?) -> Void) {
        guard let url = URL(string: string) else {
            complete(nil, JSONFeedReaderError.invalidRequestString)
            return
        }
        read(url: url, complete: complete)
    }
}
