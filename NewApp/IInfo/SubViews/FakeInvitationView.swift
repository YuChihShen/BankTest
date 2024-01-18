//
//  FakeInvitationView.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/17.
//

import UIKit

class FakeInvitationView: UIView {

    @IBOutlet weak var firstCard: UIView!
    @IBOutlet weak var firstCardShadow: UIView!
    
    @IBOutlet weak var secondCard: UIView!
    @IBOutlet weak var secondCardShadow: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var didTapView:(() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
    }
    
    func loadXib() {
        let nib = UINib(nibName: "FakeInvitationView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self).first as! UIView
        addSubview(xibView)
        
        xibView.translatesAutoresizingMaskIntoConstraints = false
        xibView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        xibView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        xibView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        xibView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        setUI()
        self.tapGesture.addTarget(self, action: #selector(tapView))
    }
    
    func setUI() {
        firstCard.layer.cornerRadius = 6.0
        firstCard.layer.shadowOpacity = 1
        firstCard.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        firstCard.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        firstCard.layer.shadowRadius = 16.0
        
        secondCard.layer.cornerRadius = 6.0
        secondCard.layer.shadowOpacity = 1
        secondCard.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        secondCard.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        secondCard.layer.shadowRadius = 16.0
    }
    
    @objc func tapView() {
        self.didTapView?()
    }
    
    func configureViewWithFriend(friend:Friend) {
        nameLabel.text = friend.name
    }

}
