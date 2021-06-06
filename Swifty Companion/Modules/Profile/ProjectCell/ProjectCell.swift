//
//  ProjectCell.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 05.06.2021.
//

import UIKit

class ProjectCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var markLabel: UILabel!
    @IBOutlet var clockImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.65)
        
        titleLabel.textColor = .white
        markLabel.textColor = .white
        
        let templateClockImage = clockImage.image?.withTintColor(.yellow)
        clockImage.image = templateClockImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedBackgroundView?.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.95)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        selectedBackgroundView?.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.95)
    }
}
