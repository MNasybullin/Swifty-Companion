//
//  NetworkConstants.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 21.05.2021.
//

import Foundation

public enum Constants {
    static let baseUrl = URL(string: "https://api.intra.42.fr/")

    static let accessTokenUrl = URL(string: "oauth/token/", relativeTo: baseUrl)
    static let profileDataUrl = URL(string: "v2/users/", relativeTo: baseUrl)
}

public enum RequestMethod {
    static let post = "POST"
    static let get = "GET"
}

public enum ContentType {
    static let json = "application/json"
}

public struct AppParameters: Codable {
    var grant_type = "client_credentials"
    var client_id = "2a1a6448f0b7c176678a27bfdbcea99cf64c46d23b66f3a01d50c0c1205aa168"
    var client_secret = "84f2befd2c0e8db79c1c85ce5286d43e55e4e50f62ea0ee57b543bf3bf071e09"
}
