//
//  InfoViewModel.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/12.
//

import UIKit

protocol infoDataDelegate {
    func didUpdateDataWithViewModel(viewModel:InfoViewModel)
}

class InfoViewModel: NSObject {
    var delegate:infoDataDelegate?
    var user:User?
    var friendList:[Friend] = []
    var candidateFriendList:[Friend] = []
    
    var friendList1:[Friend] = []
    var friendList2:[Friend] = []
    
    func getDataForBtn1() {
        let group = DispatchGroup()
        
        group.enter()
        APIController().getData(urlEnum: .userInfoURL) { data, response, err in
            guard let data = data else {
                group.leave()
                print("err from get user: \(err?.localizedDescription ?? "")")
                return
            }
            self.user = try? JSONDecoder().decode(UserResponse.self, from: data).response?.first
            group.leave()
        }
        
        group.enter()
        APIController().getData(urlEnum: .noDataList) { data, response, err in
            guard let data = data else {
                group.leave()
                print("err from get friendList: \(err?.localizedDescription ?? "")")
                return
            }
            self.friendList = (try? JSONDecoder().decode(FriendListResponse.self, from: data).response) ?? []
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.didUpdateDataWithViewModel(viewModel: self)
        }
    }
    
    func getDataForBtn2() {
        let group = DispatchGroup()
        
        group.enter()
        APIController().getData(urlEnum: .userInfoURL) { data, response, err in
            guard let data = data else {
                group.leave()
                print("err from get user: \(err?.localizedDescription ?? "")")
                return
            }
            self.user = try? JSONDecoder().decode(UserResponse.self, from: data).response?.first
            group.leave()
        }
        
        group.enter()
        APIController().getData(urlEnum: .friendList1) { data, response, err in
            guard let data = data else {
                group.leave()
                print("err from get friendList1: \(err?.localizedDescription ?? "")")
                return
            }
            self.friendList1 = (try? JSONDecoder().decode(FriendListResponse.self, from: data).response) ?? []
            group.leave()
        }
        
        group.enter()
        APIController().getData(urlEnum: .friendList2) { data, response, err in
            guard let data = data else {
                group.leave()
                print("err from get friendList2: \(err?.localizedDescription ?? "")")
                return
            }
            self.friendList2 = (try? JSONDecoder().decode(FriendListResponse.self, from: data).response) ?? []
            group.leave()
        }
        
        group.notify(queue: .main) {
//            var dict:[String:Friend] = [:]
            var friendToTalList = self.friendList1
            friendToTalList.append(contentsOf: self.friendList2)
            self.setCandidateFriendListAndFriendListWithArray(array: friendToTalList)
//            friendToTalList.forEach { friend in
//                if let member = dict[friend.fid] {
//                    if let memberUpdateTime = member.updateTime,
//                       let friendUpdateTime  = friend.updateTime {
//                        dict[friend.fid] = (friendUpdateTime > memberUpdateTime) ? friend : member
//                    }
//                } else {
//                    dict[friend.fid] = friend
//                }
//            }
//            self.friendList = (dict.map{ $0.value } as? [Friend]) ?? []
//            self.friendList.sort(by: {(Int($0.fid) ?? 0) < (Int($1.fid) ?? 0)})
//            self.candidateFriendList = self.friendList.filter({ $0.status == 0 })
//            self.friendList = self.friendList.filter({ $0.status != 0 })
            
            self.delegate?.didUpdateDataWithViewModel(viewModel: self)
        }
    }
    
    func getDataForBtn3() {
        let group = DispatchGroup()
        
        group.enter()
        APIController().getData(urlEnum: .userInfoURL) { data, response, err in
            guard let data = data else {
                group.leave()
                print("err from get user: \(err?.localizedDescription ?? "")")
                return
            }
            self.user = try? JSONDecoder().decode(UserResponse.self, from: data).response?.first
            group.leave()
        }
        
        group.enter()
        APIController().getData(urlEnum: .friendAndInviteList) { data, response, err in
            guard let data = data else {
                group.leave()
                print("err from get friendList: \(err?.localizedDescription ?? "")")
                return
            }
            self.friendList = (try? JSONDecoder().decode(FriendListResponse.self, from: data).response) ?? []
            self.candidateFriendList = self.friendList.filter({ $0.status == 0 })
            self.friendList = self.friendList.filter({ $0.status != 0 })
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.didUpdateDataWithViewModel(viewModel: self)
        }
    }
    
    func setCandidateFriendListAndFriendListWithArray(array:[Friend]) {
        var dict:[String:Friend] = [:]
        array.forEach { friend in
            if let member = dict[friend.fid] {
                if let memberUpdateTime = member.updateTime,
                   let friendUpdateTime  = friend.updateTime {
                    dict[friend.fid] = (friendUpdateTime > memberUpdateTime) ? friend : member
                }
            } else {
                dict[friend.fid] = friend
            }
        }
        self.friendList = (dict.map{ $0.value } as? [Friend]) ?? []
        self.friendList.sort(by: {(Int($0.fid) ?? 0) < (Int($1.fid) ?? 0)})
        self.candidateFriendList = self.friendList.filter({ $0.status == 0 })
        self.friendList = self.friendList.filter({ $0.status != 0 })
    }

}
