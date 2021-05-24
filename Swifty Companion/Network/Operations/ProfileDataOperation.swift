//
//  ProfileDataOperation.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 24.05.2021.
//

import Foundation

final class ProfileDataOperation: AsyncOperation {
    // MARK: - Private Properties
    private var credential: Credential

    // MARK: - Blocks

    var success: ProfileDataBlock?
    var failure: ErrorBlock?

    // MARK: - Public Properties

    var login: String?

    // MARK: - Init

    init(credential: Credential) {
        self.credential = credential
        super.init()
    }

    // MARK: - Main

    override func main() {
        guard let login = login,
              let url = URL(string: login,
                            relativeTo: Constants.profileDataUrl) else {
            return
        }
        
        let accessTokenHeader = "Bearer \(credential.accessToken)"
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get

        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Authorization" : accessTokenHeader
        ]

        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: request) { [weak self] data, response, errorSession in
            if errorSession != nil {
                self?.failure?(errorSession)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "Profile data session response error", code: -1, userInfo: nil)
                self?.failure?(error)
                return
            }

            let statusCode = response.statusCode
            switch statusCode {
                case 200:
                    if let data = data,
                       let profileData = try? JSONDecoder().decode(ProfileData.self, from: data) {
                        self?.success?(profileData)
                    } else {
                        let error = NSError(domain: "Profile Data response error",
                                            code: -200,
                                            userInfo: nil)
                        self?.failure?(error)
                    }
                    
                case 400:
                    let error = NSError(domain: "The request is malformed", code: statusCode, userInfo: nil)
                    self?.failure?(error)
                
                case 401:
                    let error = NSError(domain: "Unauthorized", code: statusCode, userInfo: nil)
                    self?.failure?(error)
                    
                case 403:
                    let error = NSError(domain: "Forbidden", code: statusCode, userInfo: nil)
                    self?.failure?(error)
                    
                case 404:
                    let error = NSError(domain: "Profile is not found", code: statusCode, userInfo: nil)
                    self?.failure?(error)
                    
                case 422:
                    let error = NSError(domain: "Unprocessable entity", code: statusCode, userInfo: nil)
                    self?.failure?(error)
                    
                case 500:
                    let error = NSError(domain: "We have a problem with our server. Please try again later.", code: statusCode, userInfo: nil)
                    self?.failure?(error)
            
                default:
                    let error = NSError(domain: "Unknown error", code: statusCode, userInfo: nil)
                    self?.failure?(error)
            }
        }
        task.resume()
    }
}

