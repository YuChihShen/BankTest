//
//  DataStruct.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/12.
//

import Foundation

struct UserResponse:Codable {
    let response:[User]?
}

struct User:Codable {
    let name:String
    let kokoid:String
}

struct FriendListResponse:Codable {
    let response:[Friend]?
}

struct Friend:Codable {
    let name:String
    let status:Int
    let isTop:String
    let fid:String
    let updateDate:String
    let updateTime:Date?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(Int.self, forKey: .status)
        self.isTop = try container.decode(String.self, forKey: .isTop)
        self.fid = try container.decode(String.self, forKey: .fid)
        self.updateDate = try container.decode(String.self, forKey: .updateDate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        if let date = formatter.date(from: self.updateDate) {
            self.updateTime = date
        } else {
            formatter.dateFormat = "yyyy/MM/dd"
            self.updateTime = formatter.date(from: self.updateDate)
        }
    }
}
