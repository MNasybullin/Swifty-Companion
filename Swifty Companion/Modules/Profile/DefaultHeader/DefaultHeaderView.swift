//
//  DefaultHeaderView.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 01.06.2021.
//

import UIKit

class DefaultHeaderView: UIView {
    // MARK: - Properties

    @IBOutlet var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("DefaultHeader", owner: self, options: nil)
        contentView.constraintIn(self, top: 4, bottom: -4, leading: 4, trailing: -4)
        screenConfigure()
    }
    
    func screenConfigure() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor? = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.45)
        
        titleLabel.textColor = .white
    }

}

