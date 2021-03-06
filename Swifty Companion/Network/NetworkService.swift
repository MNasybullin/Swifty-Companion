//
//  NetworkService.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 17.05.2021.
//

import UIKit

protocol NetworkServiceProtocol {
    func getProfile(login: String, success: ProfileDataBlock?, failure: ErrorBlock?)
}

public protocol CredentialStorage {
    var credential: Credential? { get }
}

class NetworkService: NetworkServiceProtocol, CredentialStorage {
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

    func getProfile(login: String, success: ProfileDataBlock?, failure: ErrorBlock?) {
        let accessTokenOperation = AccessTokenOperation(credentialStorage: self)

        accessTokenOperation.success = { [weak self] credential in
            if credential != nil {
                self?.credential = credential
            }
            self?.getProfileData(login: login, success: success, failure: failure)
        }
        accessTokenOperation.failure = { error in
            failure?(error)
        }
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(accessTokenOperation)
    }

    private func getProfileData(login: String, success: ProfileDataBlock?, failure: ErrorBlock?) {
        let profileDataOperation = ProfileDataOperation(credential: credential)
        profileDataOperation.login = login

        profileDataOperation.success = { [weak self] profileData in
            self?.getImageData(profileData: profileData, success: success, failure: failure)
        }
        profileDataOperation.failure = { error in
            failure?(error)
        }

        let operationQueue = OperationQueue()
        operationQueue.addOperation(profileDataOperation)
    }

    private func getImageData(profileData: ProfileData, success: ProfileDataBlock?, failure: ErrorBlock?) {
        let imageDataOperation = ImageDataOperation(imageUrl: profileData.imageUrl)

        imageDataOperation.success = { data in
            var newProfileData = profileData
            newProfileData.imageData = data
            success?(newProfileData)
        }

        imageDataOperation.failure = { error in
            failure?(error)
        }

        let operationQueue = OperationQueue()
        operationQueue.addOperation(imageDataOperation)
    }
}
