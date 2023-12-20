//
//  SleepPageTests.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 19.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class SleepPageTests: BaseTest {
    
    override func setUp() {
        super.setUp()
        loginScreen.login(email: loginScreen.correctLogin, password: loginScreen.correctPassword)
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "User does not on tasks page")
    }
    
    func testSelectAllSleepTasks() throws {
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User does not on tasks page")
        
        sleepScreen.actionsWithAllTasks(action: .completeAll)
        try sleepScreen.checkAllTasksStatuses(status: sleepScreen.taskSelected)
    }
    
    func testUnselectAllSleepTasks() throws {
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User does not on sleep page")
        
        sleepScreen.actionsWithAllTasks(action: .completeAll)
        try sleepScreen.checkAllTasksStatuses(status: sleepScreen.taskSelected)
        
        let options = XCTExpectedFailure.Options()
                
        if sleepScreen.cancelAllButton.isEnabled {
            options.isEnabled = false
            sleepScreen.actionsWithAllTasks(action: .cancelAll)
            try sleepScreen.checkAllTasksStatuses(status: sleepScreen.taskNotSelected)
        } else {
            options.isEnabled = true
            XCTExpectFailure("Cancel all button doesn't appeared", options: options)
        }
    }
    
    func testSelectSleepTask() {

        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on sleep tasks page")
        
        sleepScreen.markedTask.tap()
        sleepScreen.checkingTaskStatus(expectedResult: sleepScreen.taskSelected, actualResult: sleepScreen.markedTaskStatus as! String)
        
        sleepScreen.checkOtherTasksStatuses(status: sleepScreen.taskNotSelected)
    }
    
    func testUnselectSleepTask() {

        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on sleep tasks page")
        
        sleepScreen.markedTask.tap()
        
        sleepScreen.checkingTaskStatus(expectedResult: sleepScreen.taskSelected, actualResult: sleepScreen.markedTaskStatus as! String)
        sleepScreen.checkOtherTasksStatuses(status: sleepScreen.taskNotSelected)
        
        sleepScreen.markedTask.tap()
        
        sleepScreen.checkingTaskStatus(expectedResult: sleepScreen.taskNotSelected, actualResult: sleepScreen.markedTaskStatus as! String)
        sleepScreen.checkOtherTasksStatuses(status: sleepScreen.taskNotSelected)
    }
    
    func testSortSleepTasksByName() {
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User does not on sleep tasks page")

        sleepScreen.actionsWithAllTasks(action: .sortByName)
        XCTAssert(sleepScreen.tasksList.element.waitForExistence(timeout: 5), "Sleep tasks list doesn't exist")

        let options = XCTExpectedFailure.Options()
        options.issueMatcher = { issue in issue.type == .assertionFailure && issue.compactDescription.contains("Invalid order of tasks")}

        for task in 0...tasksScreen.tasksList.count-2 {
            if tasksScreen.tasksList.element(boundBy: task+1).staticTexts.firstMatch.label > tasksScreen.tasksList.element(boundBy: task).staticTexts.firstMatch.label {
                options.isEnabled = false
            } else {
                options.isEnabled = true
            }
        }
        XCTExpectFailure("Sleep tasks doesn't sort by name", options: options)
    }
    
    func testAllSleepTasksMarkedWhenSleepCheckboxMarked() throws {
                
        tasksScreen.sleepCheckbox.element.tap()
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on Sleep tasks screen")
        
        try sleepScreen.checkAllTasksStatuses(status: sleepScreen.taskSelected)
    }
    
    func testBackToTasksPageFromSleepPage() {
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on sleep tasks screen")
        
        sleepScreen.backToTasksButton.tap()
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "User doesn't on tasks page")
    }
    
    func testVerifyCompleteAllChangeToCancellAll() throws {
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on sleep tasks page")
        
        sleepScreen.actionsWithAllTasks(action: .completeAll)
        try sleepScreen.checkAllTasksStatuses(status: sleepScreen.taskSelected)
        
        let options = XCTExpectedFailure.Options()
        
        if sleepScreen.cancelAllButton.exists {
            options.isEnabled = false
        } else {
            options.isEnabled = true
        }
        
        XCTExpectFailure("Complete All button doesn't change to Cancel All", options: options)
    }
    
    func testSortingStateOfSleepTasks() {
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on sleep tasks page")
        
        sleepScreen.actionsWithAllTasks(action: .sortByName)
        XCTAssert(sleepScreen.tasksList.element.waitForExistence(timeout: 5), "Sleep tasks list doesn't exist")
        
        let options = XCTExpectedFailure.Options()
        options.issueMatcher = { issue in issue.type == .assertionFailure && issue.compactDescription.contains("Invalid order of tasks")}
        
        for task in 0...tasksScreen.tasksList.count-2 {
            if tasksScreen.tasksList.element(boundBy: task+1).staticTexts.firstMatch.label > tasksScreen.tasksList.element(boundBy: task).staticTexts.firstMatch.label {
                options.isEnabled = false
            } else {
                options.isEnabled = true
            }
        }
        XCTExpectFailure("Sleep tasks doesn't sort by name", options: options)

        
        sleepScreen.backToTasksButton.tap()
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "User doesn't on tasks page")
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on sleep tasks page")
        
        for task in 0...tasksScreen.tasksList.count-2 {
            if tasksScreen.tasksList.element(boundBy: task+1).staticTexts.firstMatch.label > tasksScreen.tasksList.element(boundBy: task).staticTexts.firstMatch.label {
                options.isEnabled = false
            } else {
                options.isEnabled = true
            }
        }
        XCTExpectFailure("Sleep tasks doesn't sort by name", options: options)

    }
}
