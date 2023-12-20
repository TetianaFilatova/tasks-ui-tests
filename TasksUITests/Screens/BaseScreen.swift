//
//  BaseScreen.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 14.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class BaseScreen {
    static let app = XCUIApplication()
    static let springboard: XCUIApplication = .init(bundleIdentifier: "com.apple.springboard")
    
}
