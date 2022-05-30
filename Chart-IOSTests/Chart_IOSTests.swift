//
//  Chart_IOSTests.swift
//  Chart-IOSTests
//
//  Created by 김대희 on 2022/04/07.
//

import XCTest
@testable import Chart_IOS

class Chart_IOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        print("-github INFO PLIST 가져오기-")
        print(Base.githubClientId!)
        print(Base.clientSecret!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
