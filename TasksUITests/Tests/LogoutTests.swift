//
//  LogoutTests.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 19.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class LogoutTests: BaseTest {
    
    override func setUp() {
        super.setUp()
        loginScreen.login(email: loginScreen.correctLogin, password: loginScreen.correctPassword)
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "User does not on tasks page")
    }
    
    func testLogoutFromTasksPage() {
        
        tasksScreen.logout(action: .logout)
        XCTAssert(loginScreen.emailField.waitForExistence(timeout: 3), "User doesn't log out")
    }
    
    func testUnsuccessfulLogoutFromTasksPage() {
        
        tasksScreen.logout(action: .cancel)
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "Unsuccessful login cancellation")
    }
    
    func testLogoutFromSleepPage() {

        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User does not on sleep tasks page")
        
        sleepScreen.logout(action: .logout)
        XCTAssert(loginScreen.emailField.waitForExistence(timeout: 3), "User doesn't log out")
    }
    
    func testUnsuccessfulLogoutFromSleepPage() {

        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User does not on sleep tasks page")
        
        sleepScreen.logout(action: .cancel)
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "Unsuccessful login cancellation")
    }
}
