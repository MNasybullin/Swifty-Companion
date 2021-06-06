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
    
    private enum HeightForHeaderConstant {
        static let profileHeader: CGFloat = 293
        static let defaultHeader: CGFloat = 59
    }
    
    private enum HeightForRowConstant {
        static let projectRow: CGFloat = 51
        static let skillRow: CGFloat = 70
    }

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
        navigationItem.title = commonData.login.uppercased()
        navigationItem.largeTitleDisplayMode = .never

        tableView.register(UINib(nibName: "ProjectCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
        tableView.register(UINib(nibName: "SkillCell", bundle: nil), forCellReuseIdentifier: "SkillCell")
        tableView.backgroundView = UIImageView(image: UIImage(named: "background2"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
        tableView.separatorColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.65)
    }
    
    func profileInfoHeaderConfigure() -> ProfileInfoHeaderView {
        let profileInfoHeader = ProfileInfoHeaderView()
        if let imageData = commonData.imageData {
            profileInfoHeader.profileImage.image = UIImage(data: imageData)
        }
        profileInfoHeader.displayNameLabel.text = commonData.displayName
        profileInfoHeader.walletLabel.text = "Wallet: \(commonData.wallet)"
        profileInfoHeader.evaluationPointsLabel.text = "Evaluation points: \(commonData.correctionPoint)"
        profileInfoHeader.emailLabel.text = commonData.email
        profileInfoHeader.campusLabel.text = commonData.campusName

        let levelIntLiteral = currentCursus.level.rounded(.down)
        let levelHundredsInt = (currentCursus.level - levelIntLiteral) * 100
        profileInfoHeader.levelLabel.text = "level \(Int(levelIntLiteral)) - \(Int(levelHundredsInt.rounded()))%"

        profileInfoHeader.levelProgressView.progress = Float(levelHundredsInt) / 100
        profileInfoHeader.cursusButton.setTitle(currentCursus.cursus.name, for: .normal)
        
        profileInfoHeader.buttonAction = {
            let ac = UIAlertController(title: "Select cursus", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            for cursus in self.cursusData {
                ac.addAction(UIAlertAction(title: cursus.cursus.name, style: .default, handler: { _ in
                    self.currentCursus = cursus
                    UIView.transition(with: self.tableView,
                                      duration: 0.35,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tableView.reloadData() })
                }))
            }
            self.present(ac, animated: true, completion: nil)
        }
        return profileInfoHeader
    }
    
    func projectsHeaderConfigure() -> DefaultHeaderView  {
        let projectsHeader = DefaultHeaderView()
        projectsHeader.titleLabel.text = "PROJECTS"
        return projectsHeader
    }
    
    func skillsHeaderConfugure() -> DefaultHeaderView {
        let skillsHeader = DefaultHeaderView()
        skillsHeader.titleLabel.text = "SKILLS"
        return skillsHeader
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return HeightForHeaderConstant.profileHeader
        } else {
            return HeightForHeaderConstant.defaultHeader
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 1:
                return HeightForRowConstant.projectRow
            case 2:
                return HeightForRowConstant.skillRow
            default:
                return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            case 0:
                return profileInfoHeaderConfigure()
            case 1:
                return projectsHeaderConfigure()
            case 2:
                return skillsHeaderConfugure()
            default:
                return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 1:
                return currentCursus.projects.count
            case 2:
                return currentCursus.skills.count
            default:
                return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 1:
                return projectCellConfigure(tableView, cellForRowAt: indexPath)
            case 2:
                return skillCellConfigure(tableView, cellForRowAt: indexPath)
            default:
                return UITableViewCell()
        }
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Cell Configure
    
    func projectCellConfigure(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        
        let row = indexPath.row
        
        if !currentCursus.projects[row].children.isEmpty {
            let imageView = UIImageView(image: UIImage(systemName: "chevron.down.square")?.withTintColor(.white, renderingMode: .alwaysOriginal))
            cell.accessoryView = imageView
        }

        cell.titleLabel.text = currentCursus.projects[row].project.name
        if currentCursus.projects[row].finalMark != nil {
            cell.markLabel.text = String( currentCursus.projects[row].finalMark!)
            if currentCursus.projects[row].validated == true {
                cell.markLabel.textColor = .green
            } else {
                cell.markLabel.textColor = .red
            }
            cell.clockImage.isHidden = true
            cell.markLabel.isHidden = false
        } else {
            cell.markLabel.isHidden = true
            cell.clockImage.isHidden = false
        }

        return cell
    }
    
    func skillCellConfigure(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath) as! SkillCell
        
        let row = indexPath.row
        
        cell.titleLabel.text = currentCursus.skills[row].name
        cell.markLabel.text = String(format: "%.2f", currentCursus.skills[row].level)
        let progress = currentCursus.skills[row].level / 20
        cell.progressView.progress = Float(progress)
        return cell
    }
}

// MARK: - Input Protocol

extension ProfileViewController: ProfileViewInputProtocol {
}
