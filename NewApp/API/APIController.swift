//
//  APIController.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/12.
//

import UIKit

class APIController: NSObject {
    
    enum URLString:String {
        case userInfoURL =           "https://dimanyen.github.io/man.json"
        case friendList1 =           "https://dimanyen.github.io/friend1.json"
        case friendList2 =           "https://dimanyen.github.io/friend2.json"
        case friendAndInviteList =   "https://dimanyen.github.io/friend3.json"
        case noDataList =            "https://dimanyen.github.io/friend4.json"
    }
    
    func getData(urlEnum:URLString ,completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) {
        let request = URLRequest(url: URL(string: urlEnum.rawValue)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            completionHandler(data, response, err)
        }
        task.resume()
    }
    
    
}
