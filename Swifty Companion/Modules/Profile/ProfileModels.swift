//
//  ProfileModels.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 01.06.2021.
//

import Foundation

struct CommonData {
    var email: String
    var login: String
    var displayName: String
    var imageData: Data?
    var correctionPoint: Int
    var wallet: Int
    var campusName: String
}

struct CursusData {
    var level: Double
    var skills: [Skills]
    var cursus: Cursus
    var projectsUsers: [ProjectsUsers]
}
