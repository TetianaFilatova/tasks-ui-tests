//
//  BaseTest.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 14.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase {
    
    let app = XCUIApplication()
    let loginScreen = LoginScreen()
    let tasksScreen = TasksScreen()
    let sleepScreen = SleepScreen()
    
    override func setUp() {
        super.setUp()
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        tasksScreen.logout(action: .logout)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    
    func deleteApp() {
        app.terminate()
        
        let icon = BaseScreen.springboard.icons["Tasks"]
        icon.press(forDuration: 1.3)
        
        let removeAppButton = BaseScreen.springboard.buttons["Remove App"]
        if removeAppButton.waitForExistence(timeout: 2) {
            removeAppButton.tap()
        } else {
            XCTFail("Remove app button does not appeared")
        }
        
        let deleteAppButton = BaseScreen.springboard.buttons["Delete App"]
        if deleteAppButton.waitForExistence(timeout: 2) {
            deleteAppButton.tap()
        } else {
            XCTFail("Delete app button does not appeared")
        }
        
        let deleteButton = BaseScreen.springboard.buttons["Delete"]
        if deleteButton.waitForExistence(timeout: 2) {
            deleteButton.tap()
        } else {
            XCTFail("Delete button does not appeared")
        }
    }
}
