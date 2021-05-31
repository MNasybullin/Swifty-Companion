//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 20.05.2021.
//

import UIKit

class ProfileViewController: UITableViewController {

    // MARK: - Public Properties

    var profileData: ProfileData!
    
    // MARK: - Section Views
    var profileInfo: ProfileInfoView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if profileData == nil {
            fatalError("ProfileViewController: profileData is nil!")
        }

        navigationItem.largeTitleDisplayMode = .never
        profileInfo = ProfileInfoView()
        profileInfo.displayNameLabel.text = profileData.displayName
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return profileInfo
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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
