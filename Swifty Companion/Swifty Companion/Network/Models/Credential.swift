//
//  Credential.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 21.05.2021.
//

import Foundation

public struct Credential: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken
        case tokenType
        case expiresIn
        case scope
        case createdAt
    }

    let accessToken: String
    let tokenType: String
    let expiresIn: Double
    let scope: String
    let createdAt: Double

    init(from credential: CredentialResponse) {
        self.accessToken = credential.accessToken
        self.tokenType = credential.tokenType
        self.expiresIn = Double(credential.expiresIn)
        self.scope = credential.scope
        self.createdAt = Double(credential.createdAt)
    }
}

extension Credential {
    func isExpired() -> Bool {
        let expiredDate = Date(timeIntervalSince1970: createdAt + expiresIn)
        return Date().compare(expiredDate) == .orderedDescending
    }
}
