## Greetings %username% !

This is a quick manual on what we expect from you during performing the test task.

This will be a simple app that contains two features: Login & Checklist.

* First of all, get to know with the application under test, build the test app and check out its possibilities and bugs. 

* Second of all, we need to evaluate your qa manual background, so create down below:
 - short testplan 
 - list of the testcases
 - list of discovered issues
 
* Third of all, write test automation according test automation purposes  

* And fourth of all, push the whole project to github.com and notice us with a link to your repo on completion. 

Please reachout Yuliia (yvolkova@readdle.com) if you have any questions.

## Good Luck!
* p.s. Do not tamper codebase of application

#YOUR TASK STARTS HERE: 


# TEST PLAN: 

- Environment: 
XCode version 15.1
Simulator iPhone 15 Pro Max - iOS 17.2
Application Tasks version 1.0

- What parts of app will be tested:
1. Installation
2. Login page
3. Tasks page
4. Sleep page
5. Navigation from Tasks page to Sleep page and back
6. "Complete All" button(on Sleep page & Tasks page)
7. "Cancel All" button(on Sleep page & Tasks page)
8. "Sort By Name" button(on Sleep page & Tasks page)
9. Logout(from Sleep page & Tasks page)

# LIST OF TEST CASES: 
// Only summaries of tests:

- Login with valid email & password
- Verify user can't login with empty email field
- Verify user can't login with empty password field
- Verify user can't login with invalid email & valid password
- Mark one task checkbox "done" on Tasks Page
- Unmark one task checkbox on Tasks Page
- Mark all tasks checkboxe's "done" with "Complete All" button on Tasks Page
- Unmark all tasks checkboxe's with "Cancel All" on Tasks Page
- Verify "Complete All" button change to "Cancel All" button, if all tasks checkboxe's mark as "Done" on Tasks Page
- Verify task's are displayed in alphabetical order after tapping the "Sort by name" button on Tasks Page
- Verify Sort by name saved on Tasks Page after switching to Sleep page and back
- Open "Sleep" page
- Verify all task's on Sleep Page marked as "done", if "Sleep" checkbox marked as "done" on Tasks Page
- Mark one task checkbox "done" on Sleep Page
- Unmark one task checkbox on Sleep page
- Mark all tasks checkboxe's "done" with "Complete All" button on Sleep Page
- Unmark all tasks checkboxe's with "Cancel All" on Sleep Page
- Verify "Complete All" button change to "Cancel All" button, if all tasks checkboxe's mark as "Done" on Sleep Page
- Verify task's are displayed in alphabetical order after tapping the "Sort by name" button on Sleep Page
- Verify Sort by name saved on Sleep Page after switching to Tasks page and back
- Back to Tasks Page from Sleep page
- Logout from Tasks page
- Logout from Sleep page
- Cancel logout from Tasks page
- Cancel logout from Sleep page





# LIST OF DISCOVERED ISSUES:
// Only summaries of bug reports: e.g.
**Bug reports marked with "!" not 100% reproduced

- User can log in with invalid email (with non-existence domen)
- ! Tap on the checkbox marking as done another checkbox on Tasks Page
- ! "Complete All" button after tap doesn't change to "Cancel All" button on Tasks Page
- ! All checkboxes are not selected after tap "Complete All" button on Tasks Page
- ! The checkbox remains marked as done after tapping on it again on Tasks page
- ! Tap on the checkbox marking as done another checkbox on Sleep Page
- ! "Complete All" button after tap doesn't change to "Cancel All" button on Sleep Page
- ! All checkboxes are not selected after tap "Complete All" button on Sleep Page
- Sorting by name is not saved on the Sleep tasks page after switching to Tasks page and back
- ! The checkbox remains marked as done after tapping it again on Sleep page
