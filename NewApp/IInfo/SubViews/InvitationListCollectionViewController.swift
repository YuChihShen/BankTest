//
//  InvitationListCollectionViewController.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/13.
//

import UIKit

private let reuseIdentifier = "InvitationCollectionViewCell"

class InvitationListCollectionViewController: UICollectionViewController {
    
    var candidateFriendList:[Friend] = []
    var didTapView:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapView() {
        self.didTapView?()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return candidateFriendList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InvitationCollectionViewCell
        cell.configureCellWithFriend(friend: candidateFriendList[indexPath.row])
        return cell
    }

    
}
