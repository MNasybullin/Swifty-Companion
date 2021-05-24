//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 20.05.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Public Properties

    var profileData: ProfileData!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if profileData == nil {
            fatalError("ProfileViewController: profileData is nil!")
        }
        print(profileData)
    }
}
