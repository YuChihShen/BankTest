//
//  FriendViewCell.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/13.
//

import UIKit

class FriendViewCell: UITableViewCell {

    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transCashLabel: UILabel!
    @IBOutlet weak var inviteStatusLabel: UILabel!
    @IBOutlet weak var btnMore: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reSetUI()
        
        transCashLabel.textColor = #colorLiteral(red: 0.9269953966, green: 0.003500881838, blue: 0.5476276875, alpha: 1)
        transCashLabel.layer.borderColor = #colorLiteral(red: 0.9269953966, green: 0.003500881838, blue: 0.5476276875, alpha: 1)
        transCashLabel.layer.borderWidth = 1.2
        transCashLabel.layer.cornerRadius = 2
        
        inviteStatusLabel.textColor = #colorLiteral(red: 0.600246489, green: 0.5948647857, blue: 0.5989953876, alpha: 1)
        inviteStatusLabel.layer.borderColor = #colorLiteral(red: 0.7615365982, green: 0.7564134002, blue: 0.7603443265, alpha: 1)
        inviteStatusLabel.layer.borderWidth = 1.2
        inviteStatusLabel.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        reSetUI()
    }
    
    func reSetUI() {
        self.starImg.isHidden = true
        self.inviteStatusLabel.superview?.isHidden = true
        self.btnMore.superview?.isHidden = true
    }
    
    func configureCellWithFriend(friend:Friend) {
        self.starImg.isHidden = (friend.isTop == "0")
        self.btnMore.superview?.isHidden = !(friend.status == 1)
        self.inviteStatusLabel.superview?.isHidden = !(friend.status == 2)
        self.nameLabel.text = friend.name
    }
    
}
