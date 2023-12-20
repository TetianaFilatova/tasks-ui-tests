//
//  TasksPageTests.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 19.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class TasksPageTests: BaseTest {
    
    override func setUp() {
        super.setUp()
        loginScreen.login(email: loginScreen.correctLogin, password: loginScreen.correctPassword)
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "User does not on tasks page")
    }
    
    func testSelectAllTasks() throws {
        
        tasksScreen.actionsWithAllTasks(action: .completeAll)
        try tasksScreen.checkAllTasksStatuses(status: tasksScreen.taskSelected)
    }
    
    func testUnselectAllTask() throws {
        
        tasksScreen.actionsWithAllTasks(action: .completeAll)
        try tasksScreen.checkAllTasksStatuses(status: tasksScreen.taskSelected)
        
        tasksScreen.actionsWithAllTasks(action: .cancelAll)
        try tasksScreen.checkAllTasksStatuses(status: tasksScreen.taskNotSelected)
    }
    
    func testSelectedTask() {

        tasksScreen.markedTask.tap()
        
        tasksScreen.checkingTaskStatus(expectedResult: tasksScreen.taskSelected, actualResult: tasksScreen.markedTaskStatus as! String)
        
        tasksScreen.checkOtherTasksStatuses(status: tasksScreen.taskNotSelected)
    }
    
    func testUnselectedTask() {
        
        tasksScreen.markedTask.tap()
        
        tasksScreen.checkingTaskStatus(expectedResult: tasksScreen.taskSelected, actualResult: tasksScreen.markedTaskStatus as! String)
        tasksScreen.checkOtherTasksStatuses(status: tasksScreen.taskNotSelected)
        
        tasksScreen.markedTask.tap()
        
        tasksScreen.checkingTaskStatus(expectedResult: tasksScreen.taskNotSelected, actualResult: tasksScreen.markedTaskStatus as! String)
        tasksScreen.checkOtherTasksStatuses(status: tasksScreen.taskNotSelected)
    }
    
    func testSortTasksByName() throws {
        
        tasksScreen.actionsWithAllTasks(action: .sortByName)
        XCTAssert(tasksScreen.tasksList.element.waitForExistence(timeout: 2), "Tasks list doesn't exist")
        
        let options = XCTExpectedFailure.Options()
        options.issueMatcher = { issue in issue.type == .assertionFailure && issue.compactDescription.contains("Invalid order of tasks")}
                
        for task in 0...tasksScreen.tasksList.count-2 {
            if tasksScreen.tasksList.element(boundBy: task+1).staticTexts.firstMatch.label > tasksScreen.tasksList.element(boundBy: task).staticTexts.firstMatch.label {
                options.isEnabled = false
            } else {
                options.isEnabled = true
            }
            XCTExpectFailure("Tasks doesn't sort by name", options: options)
        }
    }
    
    func testVerifyCompleteAllChangeToCancellAllOnTasksPage() throws {

        tasksScreen.actionsWithAllTasks(action: .completeAll)
        try tasksScreen.checkAllTasksStatuses(status: sleepScreen.taskSelected)
        
        let options = XCTExpectedFailure.Options()
        
        if tasksScreen.cancelAllButton.exists {
            options.isEnabled = false
        } else {
            options.isEnabled = true
        }
        
        XCTExpectFailure("Complete All button doesn't change to Cancel All", options: options)
    }
    
    func testSortingStateOfTasks() {
        
        tasksScreen.actionsWithAllTasks(action: .sortByName)
        XCTAssert(tasksScreen.tasksList.element.waitForExistence(timeout: 2), "Tasks list doesn't exist")
        
        let options = XCTExpectedFailure.Options()
        options.issueMatcher = { issue in issue.type == .assertionFailure && issue.compactDescription.contains("Invalid order of tasks")}
                
        for task in 0...tasksScreen.tasksList.count-2 {
            if tasksScreen.tasksList.element(boundBy: task+1).staticTexts.firstMatch.label > tasksScreen.tasksList.element(boundBy: task).staticTexts.firstMatch.label {
                options.isEnabled = false
            } else {
                options.isEnabled = true
            }
        }
        XCTExpectFailure("Tasks doesn't sort by name", options: options)
        
        tasksScreen.moreInfoIcon.tap()
        XCTAssert(sleepScreen.backToTasksButton.waitForExistence(timeout: 3), "User doesn't on sleep tasks page")
        
        sleepScreen.backToTasksButton.tap()
        XCTAssert(tasksScreen.tasksPage.waitForExistence(timeout: 3), "User doesn't on tasks page")
        
        for task in 0...tasksScreen.tasksList.count-2 {
            if tasksScreen.tasksList.element(boundBy: task+1).staticTexts.firstMatch.label > tasksScreen.tasksList.element(boundBy: task).staticTexts.firstMatch.label {
                options.isEnabled = false
            } else {
                options.isEnabled = true
            }
        }
        XCTExpectFailure("Tasks doesn't sort by name", options: options)
    }
}
