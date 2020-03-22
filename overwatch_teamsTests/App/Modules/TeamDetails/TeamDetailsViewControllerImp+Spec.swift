import Quick
import Nimble

@testable import overwatch_teams

final class TeamDetailsViewControllerImpSpec: QuickSpec {
    override func spec() {
        let viewSpy = TeamDetailsViewSpy()
        let viewController = TeamDetailsViewControllerImp(teamDetailsView: viewSpy)
        
        describe(".init") {
            it("should have a title") {
                expect(viewController.title).to(equal("Team Details"))
            }
        }
        
        describe(".configure(viewModel: )") {
            let stubViewModel = TeamDetailsViewModel(
                logoAddress: "stub",
                name: "stub",
                abbreviatedName: "stub",
                location: "stub"
            )
            
            viewController.configure(with: stubViewModel)
            
            it("calls configure only once") {
                expect(viewSpy.configureInvocations).to(equal(1))
            }
        }
    }
}
