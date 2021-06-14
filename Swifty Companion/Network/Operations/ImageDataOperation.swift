//
//  ImageDataOperation.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 31.05.2021.
//

import Foundation

final class ImageDataOperation: Operation {
    // MARK: - Private Properties

    private var imageUrl: String

    // MARK: - Blocks

    var success: DataBlock?
    var failure: ErrorBlock?

    // MARK: - Public Properties

    var login: String?

    // MARK: - Init

    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init()
    }

    // MARK: - Main

    override func main() {
        guard let url = URL(string: imageUrl) else {
            failure?(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get

        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, errorSession in
            if errorSession != nil {
                self.failure?(errorSession)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "Image data session response error", code: -1, userInfo: nil)
                self.failure?(error)
                return
            }

            let statusCode = response.statusCode
            switch statusCode {
                case 200:
                    if let data = data {
                        self.success?(data)
                    } else {
                        let error = NSError(domain: "Image Data response error",
                                            code: -200,
                                            userInfo: nil)
                        self.failure?(error)
                    }

                default:
                    let error = NSError(domain: "Unknown error", code: statusCode, userInfo: nil)
                    self.failure?(error)
            }
        }
        task.resume()
    }
}
