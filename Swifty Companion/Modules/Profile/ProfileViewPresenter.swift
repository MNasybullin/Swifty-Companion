//
//  ProfileViewPresenter.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 01.06.2021.
//

import UIKit

final class ProfileViewPresenter: ProfileViewOutputProtocol {
    // MARK: - Public Properties

    weak var input: ProfileViewInputProtocol?
    weak var navigationController: UINavigationController?
    
    init(input: ProfileViewInputProtocol, navigationController: UINavigationController?) {
        self.input = input
        self.navigationController = navigationController
    }

    // MARK: - ProfileViewOutputProtocol
    
    func dataConfigure(_ data: ProfileData) -> (CommonData, [CursusData]) {
        let commonData = CommonData(email: data.email,
                                    login: data.login,
                                    displayName: data.displayName,
                                    imageData: data.imageData,
                                    correctionPoint: data.correctionPoint,
                                    wallet: data.wallet,
                                    campusName: data.campus.first?.name ?? "Unknown")

        var cursusData = [CursusData]()

        for cursus in data.cursusUsers {
            var projects = [ProjectsUsers]()
            var projectsChildren = [ProjectsUsers]()

            for project in data.projectsUsers where project.cursusIds.contains(cursus.cursus.id) {
                if project.project.parentId == nil {
                    projects.append(project)
                } else {
                    projectsChildren.append(project)
                }
            }
            
            for children in projectsChildren {
                var i = 0
                while i < projects.count {
                    if projects[i].project.id == children.project.parentId {
                        projects[i].children.append(children)
                    }
                    i += 1
                }
            }

            let course = CursusData(level: cursus.level,
                                    skills: cursus.skills,
                                    cursus: cursus.cursus,
                                    projects: projects)
            cursusData.append(course)
        }

        return (commonData, cursusData)
    }
}
