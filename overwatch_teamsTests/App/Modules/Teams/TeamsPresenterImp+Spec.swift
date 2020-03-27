import Quick
import Nimble

@testable import overwatch_teams

final class TeamsPresenterImpSpec: QuickSpec {
    override func spec() {
        var viewControllerSpy: TeamsViewControllerSpy!
        var useCasesMock: TeamsUseCasesMock!
        var routerSpy: TeamsRouterSpy!
        
        beforeEach {
            viewControllerSpy = TeamsViewControllerSpy()
            useCasesMock = TeamsUseCasesMock()
            routerSpy = TeamsRouterSpy()
        }
        
        describe(".init") {
            context("when getTems dot not has a response") {
                beforeEach {
                    useCasesMock.expectedResult = nil
                    
                    _ = TeamsPresenterImp(
                        viewController: viewControllerSpy,
                        teamsUseCases: useCasesMock,
                        router: routerSpy
                    )
                }
                
                it("calls configure only once: .loading") {
                    expect(viewControllerSpy.configureInvocations).toEventually(equal(1))
                }
                
                it("calls getTeams only once") {
                    expect(useCasesMock.getTeamsInvocations).toEventually(equal(1))
                }
                
                it("does not call teamSelected") {
                    expect(routerSpy.teamSelectedInvocations).toEventually(equal(0))
                }
            }
            
            context("when getTems' response has success and hasn't cache") {
                beforeEach {
                    useCasesMock.expectedResult = .successWithoutCache
                    
                    _ = TeamsPresenterImp(
                        viewController: viewControllerSpy,
                        teamsUseCases: useCasesMock,
                        router: routerSpy
                    )
                }
                
                it("calls configure two times: .loading + .showContent") {
                    expect(viewControllerSpy.configureInvocations).toEventually(equal(2))
                }
                
                it("calls getTeams only once") {
                    expect(useCasesMock.getTeamsInvocations).toEventually(equal(1))
                }
                
                it("does not call teamSelected") {
                    expect(routerSpy.teamSelectedInvocations).toEventually(equal(0))
                }
            }
            
            context("when getTems' response has success and has cache") {
                beforeEach {
                    useCasesMock.expectedResult = .successWithCache
                    
                    _ = TeamsPresenterImp(
                        viewController: viewControllerSpy,
                        teamsUseCases: useCasesMock,
                        router: routerSpy
                    )
                }
                
                it("calls configure three times: .loading + .showContent + .showContent") {
                    expect(viewControllerSpy.configureInvocations).toEventually(equal(3))
                }
                
                it("calls getTeams only once") {
                    expect(useCasesMock.getTeamsInvocations).toEventually(equal(1))
                }
                
                it("does not call teamSelected") {
                    expect(routerSpy.teamSelectedInvocations).toEventually(equal(0))
                }
            }
            
            context("when getTems' response has failure and hasn't cache") {
                beforeEach {
                    useCasesMock.expectedResult = .failureWithoutCache
                    
                    _ = TeamsPresenterImp(
                        viewController: viewControllerSpy,
                        teamsUseCases: useCasesMock,
                        router: routerSpy
                    )
                }
                
                it("calls configure two times: .loading + .showError") {
                    expect(viewControllerSpy.configureInvocations).toEventually(equal(2))
                }
                
                it("calls getTeams only once") {
                    expect(useCasesMock.getTeamsInvocations).toEventually(equal(1))
                }
                
                it("does not call teamSelected") {
                    expect(routerSpy.teamSelectedInvocations).toEventually(equal(0))
                }
            }
            
            context("when getTems' response has failure and has cache") {
                beforeEach {
                    useCasesMock.expectedResult = .failureWithCache
                    
                    _ = TeamsPresenterImp(
                        viewController: viewControllerSpy,
                        teamsUseCases: useCasesMock,
                        router: routerSpy
                    )
                }
                
                fit("calls configure two times: .loading + .showContent") {
                    expect(viewControllerSpy.configureInvocations).toEventually(equal(2))
                }
                
                it("calls getTeams only once") {
                    expect(useCasesMock.getTeamsInvocations).toEventually(equal(1))
                }
                
                it("does not call teamSelected") {
                    expect(routerSpy.teamSelectedInvocations).toEventually(equal(0))
                }
            }
        }
        
        describe(".eventHandler") {
            var presenter: TeamsPresenter!
            
            beforeEach {
                useCasesMock.expectedResult = .successWithoutCache
                
                presenter = TeamsPresenterImp(
                    viewController: viewControllerSpy,
                    teamsUseCases: useCasesMock,
                    router: routerSpy
                )
                
                presenter.eventHandler(event: .elementSelected(rowIndex: 0))
            }
            
            it("calls teamSelected once") {
                expect(routerSpy.teamSelectedInvocations).toEventually(equal(1))
            }
        }
    }
}
