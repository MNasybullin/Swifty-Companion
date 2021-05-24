//
//  AccessTokenOperation.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 21.05.2021.
//

import Foundation

final class AccessTokenOperation: Operation {
    // MARK: - Credential Storage

    var credentialStorage: CredentialStorage

    // MARK: - Blocks

    var success: CredentialBlock?
    var failure: ErrorBlock?

    // MARK: - Init

    init(credentialStorage: CredentialStorage) {
        self.credentialStorage = credentialStorage
        super.init()
    }

    // MARK: - Main

    override func main() {
        if credentialStorage.credential != nil && credentialStorage.credential?.isExpired() == false {
            success?(credentialStorage.credential!)
            return
        }
        guard let url = Constants.accessTokenUrl else {
            return
        }

        let body = AppParameters()
        let encodedData = try? JSONEncoder().encode(body)

        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post
        request.httpBody = encodedData

        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Content-Type": ContentType.json
        ]

        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, errorSession in
            if errorSession != nil {
                self.failure?(errorSession)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "Access Token session response error", code: -1, userInfo: nil)
                self.failure?(error)
                return
            }

            let statusCode = response.statusCode
            switch statusCode {
                case 200:
                    if let data = data,
                       let credential = try? JSONDecoder().decode(Credential.self, from: data) {
                        self.success?(credential)
                    } else {
                        let error = NSError(domain: "Credential response error",
                                            code: -200,
                                            userInfo: nil)
                        self.failure?(error)
                    }
                    
                case 400:
                    let error = NSError(domain: "The request is malformed", code: statusCode, userInfo: nil)
                    self.failure?(error)
                
                case 401:
                    let error = NSError(domain: "Unauthorized", code: statusCode, userInfo: nil)
                    self.failure?(error)
                    
                case 403:
                    let error = NSError(domain: "Forbidden", code: statusCode, userInfo: nil)
                    self.failure?(error)
                    
                case 404:
                    let error = NSError(domain: "Page or resource is not found", code: statusCode, userInfo: nil)
                    self.failure?(error)
                    
                case 422:
                    let error = NSError(domain: "Unprocessable entity", code: statusCode, userInfo: nil)
                    self.failure?(error)
                    
                case 500:
                    let error = NSError(domain: "We have a problem with our server. Please try again later.", code: statusCode, userInfo: nil)
                    self.failure?(error)
            
                default:
                    let error = NSError(domain: "Unknown error", code: statusCode, userInfo: nil)
                    self.failure?(error)
            }
        }
        task.resume()
    }
}

