import Quick
import Nimble

@testable import overwatch_teams

final class TeamsViewControllerImpSpec: QuickSpec {
    override func spec() {
        var viewSpy: TeamsViewSpy!
        var viewController: TeamsViewControllerImp!
        
        beforeEach {
            viewSpy = TeamsViewSpy()
            viewController = TeamsViewControllerImp(teamsView: viewSpy)
        }
        
        describe(".init(teamsView: )") {
            it("sets a value to .eventHandler") {
                expect(viewSpy.eventHandler).to(beNil())
            }
            
            it("should have a title") {
                expect(viewController.title).to(equal("Overwatch Teams"))
            }
        }
        
        describe(".configure(viewModel: )") {
            let stubViewModel = TeamsViewModel(viewState: .loading)
            
            it("calls configure only once") {
                viewController.configure(with: stubViewModel)
                
                expect(viewSpy.configureInvocations).to(equal(1))
            }
        }
    }
}
