//
//  ProfileInfoHeader.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 31.05.2021.
//

import UIKit

class ProfileInfoHeaderView: UIView {
    // MARK: - Properties

    @IBOutlet var contentView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var displayNameLabel: UILabel!
    @IBOutlet var walletLabel: UILabel!
    @IBOutlet var evaluationPointsLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var campusLabel: UILabel!
    @IBOutlet var cursusButton: UIButton!
    @IBOutlet var levelProgressView: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    var buttonAction: EmptyBlock!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("ProfileInfoHeader", owner: self, options: nil)
        contentView.constraintIn(self, top: 4, bottom: -4, leading: 4, trailing: -4)
        screenConfigure()
    }
    
    func screenConfigure() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor? = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.45)
        
        profileImage.layer.cornerRadius = 10
        
        cursusButton.layer.cornerRadius = 5
        cursusButton.setBackgroundColor(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1), forState: .disabled)
        cursusButton.setBackgroundColor(color: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), forState: .normal)
        cursusButton.tintColor = .white
        
        levelLabel.textColor = .white
        
        levelProgressView.backgroundColor = .black
        levelProgressView.layer.cornerRadius = 15
        levelProgressView.progressTintColor = .systemPurple
        levelProgressView.clipsToBounds = true
    }

    @IBAction func cursusButtonAction(_ sender: UIButton) {
        buttonAction()
    }
}
