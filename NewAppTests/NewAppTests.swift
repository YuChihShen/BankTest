//
//  NewAppTests.swift
//  NewAppTests
//
//  Created by Yu-Chih Shen on 2024/1/20.
//

import XCTest
@testable import NewApp

final class NewAppTests: XCTestCase {
    
    var viewModel:InfoViewModel!
    var friendList:[Friend]!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = InfoViewModel()
        friendList = (try? JSONDecoder().decode(FriendListResponse.self, from: testData).response) ?? []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFilterArrayData() {
        viewModel.setCandidateFriendListAndFriendListWithArray(array: friendList)
        XCTAssert(viewModel.friendList.count > 0, "朋友列表為空")
        XCTAssert(viewModel.candidateFriendList.count == 0, "應該為空陣列的列表不為空")
    }

}
