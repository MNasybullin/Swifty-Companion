//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 20.05.2021.
//

import UIKit

class ProfileViewController: UITableViewController {
    // MARK: - Private

    private var output: ProfileViewOutputProtocol!

    // MARK: - Section Views

    var profileInfoHeader: ProfileInfoHeaderView!
    var skillsHeader: DefaultHeaderView!
    var projectsHeader: DefaultHeaderView!

    // MARK: - Public Properties

    var profileData: ProfileData!
    var commonData: CommonData!
    var cursusData: [CursusData]!
    var currentCursus: CursusData!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if profileData == nil {
            fatalError("ProfileViewController: profileData is nil!")
        }
        output = ProfileViewPresenter(input: self, navigationController: navigationController)

        (commonData, cursusData) = output.dataConfigure(profileData)
        currentCursus = cursusData.first
        screenConfigure()
    }
    
    func screenConfigure() {
        navigationItem.largeTitleDisplayMode = .never

        profileInfoHeader = ProfileInfoHeaderView()
        profileInfoHeader.displayNameLabel.text = commonData.displayName
        profileInfoHeader.walletLabel.text = String(commonData.wallet)
        profileInfoHeader.evaluationPointsLabel.text = String(commonData.correctionPoint)
        profileInfoHeader.emailLabel.text = commonData.email
        profileInfoHeader.campusLabel.text = commonData.campusName

        let levelIntLiteral = currentCursus.level.rounded(.down)
        let levelHundredsInt = (currentCursus.level - levelIntLiteral) * 100
        profileInfoHeader.levelLabel.text = "level \(Int(levelIntLiteral)) - \(Int(levelHundredsInt.rounded()))%"

        profileInfoHeader.levelProgressView.progress = Float(levelHundredsInt)
        profileInfoHeader.cursusButton.titleLabel?.text = currentCursus.cursus.name

        skillsHeader = DefaultHeaderView()
        skillsHeader.titleLabel.text = "SKILLS"
        
        projectsHeader = DefaultHeaderView()
        projectsHeader.titleLabel.text = "PROJECTS"
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 240
        } else {
            return 51
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            case 0:
                return profileInfoHeader
            case 1:
                return projectsHeader
            case 2:
                return skillsHeader
            default:
                return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 0
            case 1:
                return currentCursus.projects.count
            case 2:
                return currentCursus.skills.count
            default:
                return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        cell.textLabel?.text = "text"
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

// MARK: - Input Protocol

extension ProfileViewController: ProfileViewInputProtocol {
}
