//
//  MattermostTests.swift
//  MattermostTests
//
//  Created by Vladimir Kravchenko on 13.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import XCTest
@testable import Mattermost

class MattermostTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKeychainStoring() {
        let accessToken = "testAccessToken"
        UserSessionService.save(session: UserSession(accessToken: accessToken))
        let keychainSession = UserSessionService.authorizedSession()
        
        XCTAssertEqual(keychainSession?.accessToken, accessToken)
    }
    
}
