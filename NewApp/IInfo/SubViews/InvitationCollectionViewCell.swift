//
//  InvitationCollectionViewCell.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/13.
//

import UIKit

class InvitationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 6.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 16.0
        self.layer.masksToBounds = false
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
    }
    
    func configureCellWithFriend(friend:Friend) {
        nameLabel.text = friend.name
    }

}
