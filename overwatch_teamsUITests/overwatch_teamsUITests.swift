import XCTest

class overwatch_teamsUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
    }

    func testNavigationToTeamDetails() {
        let app = XCUIApplication()
        app.launch()
        
        TeamDetailsRobot()
            .verifyIfFirstIsTeamIsDAL()
            .swipToTeamFLA()
            .navigateToFLADetails()
            .navigateBackToTeams()
    }
}
