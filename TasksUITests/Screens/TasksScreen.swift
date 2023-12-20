//
//  TasksScreen.swift
//  TasksUITests
//
//  Created by Tetiana Filatova on 14.12.2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class TasksScreen: BaseScreen {
    
    let tasksPage = app.staticTexts["Tasks"]
    let tasksList = app.tables.cells
    
    let taskIndex: Int = 0
    lazy var markedTask = tasksList.element(boundBy: taskIndex)
    lazy var markedTaskStatus = markedTask.images["cell_image_view"].value
    let moreInfoIcon = app.tables.buttons["More Info"]
    
    let sleepCheckbox = app.tables.cells.containing(.staticText, identifier:"Sleep")

    
    let taskSelected = "Selected"
    let taskNotSelected = "Not selected"
    
    let logoutButton = app.buttons["Logout"]
    let confirmLogout = app.alerts.buttons["Logout"]
    let cancelLogout = app.alerts.buttons["Cancel"]
    
    let completeAllButton = app.toolbars.buttons["Complete All"]
    let cancelAllButton = app.toolbars.buttons["Cancel All"]
    let sortByNameButton = app.toolbars.buttons["Sort by Name"]
    
        
    enum ActionsWithTasks {
        case completeAll
        case cancelAll
        case sortByName
    }
    
    enum Logout {
        case logout
        case cancel
    }
        
    public func logoutOptions (action: Logout) {
        switch action {
        case .logout:
            confirmLogout.tap()
        case .cancel:
            cancelLogout.tap()
        }
    }
    
    public func logout(action: Logout) {
        if logoutButton.exists {
            logoutButton.tap()
            logoutOptions(action: action)
        }
    }
    
    public func actionsWithAllTasks(action: ActionsWithTasks) {
        switch action {
        case .completeAll:
            completeAllButton.tap()
        case .cancelAll:
            cancelAllButton.tap()
        case.sortByName:
            sortByNameButton.tap()
        }
    }
    
    public func checkingTaskStatus(expectedResult: String, actualResult: String) {
        let options = XCTExpectedFailure.Options()
        
        if expectedResult == actualResult {
            options.isEnabled = false
        }
        
        XCTExpectFailure("Expected failure", options: options)
        XCTAssertEqual(expectedResult, actualResult)
        
    }
    
    public func checkOtherTasksStatuses(status: String) {
            for task in 0...tasksList.count-1 {
                if task != taskIndex {
                    let otherTask = tasksList.element(boundBy: task)
                    let otherTaskStatus = otherTask.images["cell_image_view"].value
                    if otherTaskStatus as! String != status {
                        XCTExpectFailure("Tasks statuses are not updated")
                    }
                }
            }
        }
    
    public func checkAllTasksStatuses(status: String) throws {
        let options = XCTExpectedFailure.Options()
            
            for taskIndex in 0...tasksList.count-1 {
                let task = tasksList.element(boundBy: taskIndex)
                let taskStatus = task.images["cell_image_view"].value
                
                if taskStatus as! String == status {
                    options.isEnabled = false
                }
                
                XCTExpectFailure("Expected exception", options: options)
                XCTAssertEqual(taskStatus as! String, status, "Wrong task status")
            }
        }
    
    public func checkTasksSortedByAscOrder() {
        let options = XCTExpectedFailure.Options()
                
        for index in 0...tasksList.count-2 {
            if tasksList.element(boundBy: index+1).staticTexts.firstMatch.label > tasksList.element(boundBy: index).staticTexts.firstMatch.label {
                options.isEnabled = false
            }
            else {
                options.isEnabled = true
            }
            
            XCTExpectFailure("Expected failure", options: options)
            XCTAssertGreaterThan(tasksList.element(boundBy: index+1).staticTexts.firstMatch.label, tasksList.element(boundBy: index).staticTexts.firstMatch.label, "Invalid order of tasks")
            
        }
    }
}
