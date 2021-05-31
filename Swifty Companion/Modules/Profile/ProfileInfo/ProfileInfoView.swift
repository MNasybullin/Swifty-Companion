//
//  ProfileInfo.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 31.05.2021.
//

import UIKit

class ProfileInfoView: UIView {
    // MARK: - Private Properties

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
            Bundle.main.loadNibNamed("ProfileInfo", owner: self, options: nil)
            contentView.fixInView(self)
        }
    @IBAction func cursusButtonAction(_ sender: UIButton) {
        print("button pressed")
    }
    
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
