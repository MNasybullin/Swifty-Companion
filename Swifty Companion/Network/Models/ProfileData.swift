//
//  ProfileData.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 24.05.2021.
//

import Foundation

public struct ProfileData: Codable {
    enum CodingKeys: String, CodingKey {
        case email
        case login
        case displayName = "displayname"
        case imageUrl = "image_url"
        case correctionPoint = "correction_point"
        case wallet
//        case cursusUsers = "cursus_users"
//        case projectsUsers = "projects_users"
//        case campus
    }

    let email: String
    let login: String
    let displayName: String
    let imageUrl: String
    let correctionPoint: Int
    let wallet: Int
//    let cursusUsers: [CursusUsers]
//    let projectsUsers: [ProjectsUsers]
//    let campus: Campus
    
}

public struct CursusUsers: Codable {
    enum CodingKeys: String, CodingKey {
        case level
        case cursus
        case skills
    }
    let level: Double
    let cursus: Cursus
    let skills: [Skills]
}

public struct Cursus: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    let id: Int
    let name: String
}

public struct Skills: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case level
    }
    let name: String
    let level: Double
}

public struct Campus: Codable {
    enum CodingKeys: String, CodingKey {
        case name
    }
    let name: String
}

public struct ProjectsUsers: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case occurrence
        case finalMark = "final_mark"
        case status
        case validate = "validate?"
        case project
        case cursusIds = "cursus_ids"
    }
    let id: Int
    let occurrence: Int
    let finalMark: Int?
    let status: String
    let validate: Bool?
    let project: Project
    let cursusIds: CursusIds
}

public struct Project: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentId = "parent_id"
    }
    let id: Int
    let name: String
    let parentId: Int?
}

public struct CursusIds: Codable {
    enum CodingKeys: String, CodingKey {
        case id
    }
    let id: [Int]
}
