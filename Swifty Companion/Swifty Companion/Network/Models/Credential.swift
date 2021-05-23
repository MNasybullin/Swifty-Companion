//
//  Credential.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 21.05.2021.
//

import Foundation

public struct Credential: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case createdAt = "created_at"
    }

    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let createdAt: Int
}

extension Credential {
    func isExpired() -> Bool {
        let expiredDate = Date(timeIntervalSince1970: Double(createdAt + expiresIn))
        return Date().compare(expiredDate) == .orderedDescending
    }
}
