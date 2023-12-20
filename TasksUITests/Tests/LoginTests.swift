//
//  LoginTests.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 19.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class LoginTests: BaseTest {
    
    func testBasicLogin() {
        
        loginScreen.login(email: loginScreen.correctLogin, password: loginScreen.correctPassword)
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "User is not logged in")
    }
    
    func testLoginWithEmptyEmailField() {
        
        XCTAssertEqual(loginScreen.loginButton.isEnabled, false)
        
        loginScreen.login(email: "", password: loginScreen.correctPassword)
        XCTAssertEqual(loginScreen.loginButton.isEnabled, false)
    }
    
    func testLoginWithEmptyPasswordField() {
        
        loginScreen.emailField.tap()
        loginScreen.emailField.typeText(loginScreen.correctLogin)
        
        XCTAssertEqual(loginScreen.loginButton.isEnabled, false)
    }
    
    func testLoginWithInvalidEmail() {
        
        loginScreen.login(email: "not.correct", password: loginScreen.correctPassword)
        
        let errorAlert: XCUIElement = app.alerts.staticTexts["Error"]
        XCTAssert(errorAlert.waitForExistence(timeout: 3), "Error alert doesn't appeared")
    }
    
    func testLoginWithInvalidEmailNegative() {
        
        loginScreen.login(email: "not@correct.email", password: loginScreen.correctPassword)
        
        let errorAlert: XCUIElement = app.alerts.staticTexts["Error"]
        let options = XCTExpectedFailure.Options()
        
        if errorAlert.exists {
            options.isEnabled = true
        } else {
            options.isEnabled = false
        }
        
        XCTExpectFailure("User logged in with invalid email", options: options)
        
        
    }
}
