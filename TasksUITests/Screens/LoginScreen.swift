//
//  LoginScreen.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 14.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class LoginScreen: BaseScreen {
    
    let emailField: XCUIElement = app.textFields["Email"]
    let passwordField: XCUIElement = app.secureTextFields["Password"]
    let loginButton: XCUIElement = app.buttons["login-button"]
    let visibleTimeout: TimeInterval = 2
    
    let loginProcessPage = app.staticTexts["Logging in"]
    let tasksPage = app.staticTexts["Tasks"]
    let errorAlert = app.alerts.buttons["Retry"]
    let pasteButton =  app.buttons["Return"]
    
    let correctLogin = "janedoe@gmail.com"
    let correctPassword = "qwerty123"
    
    public func login(email: String, password: String) {
        
        let tasksScreen = TasksScreen()
        if tasksScreen.logoutButton.exists {
            tasksScreen.logout(action: .logout)
        }
        
        emailField.tap()
        emailField.typeText(email)

        passwordField.tap()
        passwordField.typeText(password)
        
        if pasteButton.exists {
            pasteButton.tap()
        }
        
        loginButton.tap()
                
        if errorAlert.waitForExistence(timeout: 3) {
            errorAlert.tap()
            if errorAlert.waitForExistence(timeout: 3) {
                errorAlert.tap()
            }
        }

//        loginProcessPage.waitForExistence(timeout: visibleTimeout)
        XCTAssertTrue(!errorAlert.exists, "Login alert")
    }
}
