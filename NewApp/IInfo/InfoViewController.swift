//
//  InfoViewController.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/12.
//

import UIKit

class InfoViewController: UIViewController, infoDataDelegate, UISearchBarDelegate {
    
    public enum selectedBtn:Int {
        case btn1
        case btn2
        case btn3
    }

    @IBOutlet weak var fakeTabBar: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addFriendBtn: UIButton!
    @IBOutlet weak var btnShadowView: UIView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var friendStackView: UIStackView!
    @IBOutlet weak var chatCountLabel: UILabel!
    @IBOutlet weak var friendCountLabel: UILabel!
    @IBOutlet var masks: [UIView]!
    
    let viewModel = InfoViewModel()
    let refreshControl = UIRefreshControl()
    var selectedBtn:selectedBtn = .btn1
    
    var friendListVC:FriendListViewController? = nil
    var invitationVC:InvitationListCollectionViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        loadData()
        setUI()
        
        self.friendListVC?.friendListTable.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func loadData() {
        switch self.selectedBtn {
        case .btn1:
            viewModel.getDataForBtn1()
        case .btn2:
            viewModel.getDataForBtn2()
        case .btn3:
            viewModel.getDataForBtn3()
        }
    }
    
    func setUI() {
        fakeTabBar.layer.borderWidth = 1
        fakeTabBar.layer.borderColor = #colorLiteral(red: 0.9421719909, green: 0.9421718717, blue: 0.9421719909, alpha: 1)
        
        defaultView.layer.borderWidth = 1
        defaultView.layer.borderColor = #colorLiteral(red: 0.9421719909, green: 0.9421718717, blue: 0.9421719909, alpha: 1)
        
        chatCountLabel.layer.cornerRadius = 9
        chatCountLabel.layer.backgroundColor = #colorLiteral(red: 0.9756097198, green: 0.6984522939, blue: 0.8620457649, alpha: 1)
        chatCountLabel.isHidden = true
        
        friendCountLabel.layer.cornerRadius = 9
        friendCountLabel.layer.backgroundColor = #colorLiteral(red: 0.9756097198, green: 0.6984522939, blue: 0.8620457649, alpha: 1)
        friendCountLabel.isHidden = true
        
        setFriendListVC()
        setInvitationVC()
        setAddFriendBtn()
        setLinkLabelText()
    }
    
    func setAddFriendBtn() {
        addFriendBtn.layer.cornerRadius = 20.0

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = addFriendBtn.bounds
        gradientLayer.colors = [
            UIColor(red: 86/255, green: 179/255, blue: 11/255, alpha: 1).cgColor,
            UIColor(red: 166/255, green: 204/255, blue: 66/255, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        addFriendBtn.layer.insertSublayer(gradientLayer, at: 0)
        
        btnShadowView.layer.cornerRadius = 20
        btnShadowView.layer.backgroundColor = UIColor.white.cgColor
        btnShadowView.layer.shadowColor = UIColor(red: 121/255, green: 196/255, blue: 27/255, alpha: 0.4).cgColor
        btnShadowView.layer.shadowOpacity = 1
        btnShadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnShadowView.layer.shadowRadius = 8
    }
    
    func setLinkLabelText() {
        let defaultAttributes:[NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
        ]
        let linkAttributes:[NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.underlineStyle: 1,
            NSAttributedString.Key.underlineColor: UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1),
        ]
        let attributeString = NSMutableAttributedString(string: "幫助好友更快找到你？", attributes: defaultAttributes)
        attributeString.append(NSMutableAttributedString(string: "設定 KOKO ID", attributes: linkAttributes))
        
        linkLabel.attributedText = attributeString
    }
    
    func setFriendListVC() {
        self.friendListVC = FriendListViewController(nibName: "FriendListViewController", bundle: nil)
        if let vc = self.friendListVC {
            defaultView.addSubview(vc.view)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.view.topAnchor.constraint(equalTo: defaultView.topAnchor).isActive = true
            vc.view.leadingAnchor.constraint(equalTo: defaultView.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: defaultView.trailingAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: defaultView.bottomAnchor).isActive = true
            vc.view.isHidden = true
        }
    }
    
    func setInvitationVC() {
        self.invitationVC = InvitationListCollectionViewController(nibName: "InvitationListCollectionViewController", bundle: nil)
        if let vc = self.invitationVC {
            vc.view.isHidden = true
            self.friendStackView.insertArrangedSubview(vc.view, at: 0)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.view.heightAnchor.constraint(equalToConstant: 170).isActive = true
            vc.view.widthAnchor.constraint(equalToConstant: 315).isActive = true
        }
    }
    
    // MARK: - infoDataDelegate
    
    func didUpdateDataWithViewModel(viewModel: InfoViewModel) {
        for view in masks ?? [] {
            view.isHidden = true
        }
        if let kokoID = viewModel.user?.kokoid,
           kokoID.count > 0 {
            idLabel.text = "KOKO ID：\(kokoID) ＞"
        }
        else {
            idLabel.text = "設定 KOKO ID ＞"
        }
        nameLabel.text = "\(viewModel.user?.name ?? "")"
        
        chatCountLabel.isHidden = !(viewModel.friendList.count > 0)
        friendCountLabel.isHidden = !(viewModel.friendList.count > 0)
        friendCountLabel.text = "\(viewModel.friendList.filter({$0.status == 2}).count)"
        
        if let friendListVC = self.friendListVC {
            friendListVC.view.isHidden = !(viewModel.friendList.count > 0)
            friendListVC.friendList = viewModel.friendList
            friendListVC.friendListTable.reloadData()
        }
        
        if let invitationVC = self.invitationVC {
            invitationVC.view.isHidden = !(viewModel.candidateFriendList.count > 0)
            invitationVC.candidateFriendList = viewModel.candidateFriendList
            invitationVC.collectionView.reloadData()
        }
        
        self.refreshControl.endRefreshing()
    }
}
