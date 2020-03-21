import Quick
import Nimble

@testable import overwatch_teams

final class TeamsRouterImpSpec: QuickSpec {
    override func spec() {
        let navigationControllerSpy = NavigationControllerSpy()
        let router = TeamsRouterImp(currentNavigation: navigationControllerSpy)
        let model = TeamModel(
            logoAddress: "stub",
            name: "stub",
            abbreviatedName: "stub",
            location: "stub"
        )
        
        describe(".teamSelected") {
            router.teamSelected(teamSelected: model)
            
            it("sets a value to .eventHandler") {
                expect(navigationControllerSpy.pushViewControllerInvocations).to(equal(1))
            }
        }
    }
}
