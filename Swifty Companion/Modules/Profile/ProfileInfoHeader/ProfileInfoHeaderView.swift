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
    @IBOutlet weak var levelLabel: UILabel!

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
        contentView.fixInView(self)
    }

    @IBAction func cursusButtonAction(_ sender: UIButton) {
        print("button pressed")
    }
}
