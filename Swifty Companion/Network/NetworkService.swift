//
//  NetworkService.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 17.05.2021.
//

import UIKit

protocol NetworkServiceProtocol {
    func getAccessToken(success: EmptyBlock?, failure: ErrorBlock?)
}

class NetworkService: NetworkServiceProtocol {
    // MARK: - Public Properties

    var credential: Credential? {
        didSet {
            if let credential = credential,
               let data = try? JSONEncoder().encode(credential) {
                UserDefaults.standard.set(data, forKey: "credential")
            }
        }
    }

    // MARK: - Init

    init() {
        if let data = UserDefaults.standard.data(forKey: "credential"),
           let credential = try? JSONDecoder().decode(Credential.self, from: data) {
            self.credential = credential
        }
    }

    func getAccessToken(success: EmptyBlock?, failure: ErrorBlock?) {
        let accessTokenOperation = AccessTokenOperation()

        accessTokenOperation.success = { [weak self] credential in
            self?.credential = credential
            success?()
        }
        accessTokenOperation.failure = { error in
            failure?(error)
        }

        let operationQueue = OperationQueue()
        operationQueue.addOperation(accessTokenOperation)
    }
    
    func getProfileData(login: String, success: ProfileDataBlock?, failure: ErrorBlock?) {
        guard let credential = credential else {
            return
        }

        let profileDataOperation = ProfileDataOperation(credential: credential)
        profileDataOperation.login = login
        
        profileDataOperation.success = { profileData in
            success?(profileData)
        }
        profileDataOperation.failure = { error in
            failure?(error)
        }

        let operationQueue = OperationQueue()
        operationQueue.addOperation(profileDataOperation)
    }
}
