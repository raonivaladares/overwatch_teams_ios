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
                
                it("calls configure three times: .loading + .showContent + .showError") {
                    expect(viewControllerSpy.configureInvocations).toEventually(equal(3))
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

private var teamsModelsFoo: [TeamModel] = [
    .init(logoAddress: "https://bnetcmsus-a.akamaihd.net/cms/page_media/NO44N7DDJAPF1508792362936.png", name: "Dallas Fuel Stub", abbreviatedName: "DAL", location: "Dallas, TX"),
    .init(logoAddress: "https://bnetcmsus-a.akamaihd.net/cms/page_media/3JZTLCPH37QD1508792362853.png", name: "Philadelphia Fusion Stub", abbreviatedName: "PHI", location: "Philadelphia, PA"),
    .init(logoAddress: "https://bnetcmsus-a.akamaihd.net/cms/page_media/8RS25ECY3PZH1515523733716.png", name: "Boston Uprising Stub", abbreviatedName: "BOS", location: "Boston, MA"),
    .init(logoAddress: "https://bnetcmsus-a.akamaihd.net/cms/page_media/9r/9RYLM8FICLJ01508818792450.png", name: "New York Excelsior Stub", abbreviatedName: "NYE", location: "New York City, NY"),
    .init(logoAddress: "https://images.blz-contentstack.com/v3/assets/blt321317473c90505c/blte679a761205b5d5f/5e1763e38691147ecf07e0f6/OWL_SFShock_Icon_1C_SILVER-01.png", name: "San Francisco Shock Stub", abbreviatedName: "SFS", location: "San Francisco, CA"),
    .init(logoAddress: "https://images.blz-contentstack.com/v3/assets/blt321317473c90505c/blta03a226e8c5d90d5/5e14d2882a6ac40d0b660935/OWL_LAValiant_Icon_2020_PNG.png", name: "Los Angeles Valiant Stub", abbreviatedName: "VAL", location: "Los Angeles, CA"),
    .init(logoAddress: "https://bnetcmsus-a.akamaihd.net/cms/page_media/3AEMOZZL76PF1508792362892.PNG", name: "Los Angeles Gladiators Stub", abbreviatedName: "GLA", location: "Los Angeles, CA"),
    .init(logoAddress: "https://images.blz-contentstack.com/v3/assets/blt321317473c90505c/blt3899fe69781c6ce4/5e14d29bdc2ac60d1dd16e67/OWL_FloridaMayhem_Icon_2020.png", name: "Florida Mayhem Stub", abbreviatedName: "FLA", location: "Florida"),
]
