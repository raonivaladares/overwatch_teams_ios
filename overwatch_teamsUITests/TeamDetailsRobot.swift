final class TeamDetailsRobot: Robot {
    func verifyIfFirstIsTeamIsDAL() -> TeamDetailsRobot {
        let tableView = app.tables.matching(identifier: "teamsTableView")
        
        let dalCell = tableView.cells.element(matching: .cell, identifier: "teamCellDAL")
        assertExists(dalCell)
        
        return self
    }
    
    func swipToTeamFLA() -> TeamDetailsRobot {
        let tableView = app.tables.matching(identifier: "teamsTableView")
        tableView.element.swipeUp()
        
        let flaCell = tableView.cells.element(matching: .cell, identifier: "teamCellFLA")
        assertExists(flaCell)
        
        return self
    }
    
    func navigateToFLADetails() -> TeamDetailsRobot {
        let tableView = app.tables.matching(identifier: "teamsTableView")
        
        let flaCell = tableView.cells.element(matching: .cell, identifier: "teamCellFLA")
        flaCell.tap()
        
        let navigationTitle = app.staticTexts["Team Details"]
        assertExists(navigationTitle)
        
        return self
    }
    
    @discardableResult
    func navigateBackToTeams() -> TeamDetailsRobot {
        let navigationBack = app.navigationBars.buttons.element(boundBy: 0)
        navigationBack.tap()
        
        let navigationTitle = app.staticTexts["Overwatch Teams"]
        assertExists(navigationTitle)
        
        return self
    }
}
