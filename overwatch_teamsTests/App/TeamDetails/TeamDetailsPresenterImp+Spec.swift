import Quick
import Nimble

@testable import overwatch_teams

final class TeamDetailsPresenterImpSpec: QuickSpec {
    override func spec() {
        let viewControllerSpy = TeamDetailsViewControllerSpy()
        let model = TeamModel(
            logoAddress: "stub",
            name: "stub",
            abbreviatedName: "stub",
            location: "stub"
        )
        
        describe(".init") {
            _ = TeamDetailsPresenter(viewController: viewControllerSpy, teamModel: model)
            
            it("calls configure only once") {
                expect(viewControllerSpy.configureInvocations).to(equal(1))
            }   
        }
    }
}
