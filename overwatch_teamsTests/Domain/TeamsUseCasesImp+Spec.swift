import Quick
import Nimble
import Combine

@testable import overwatch_teams

final class TeamsUseCasesImpSpec: QuickSpec {
    override func spec() {
        var webServiceMock: TeamsWebServiceMock!
        var repositoryMock: TeamsRealmRepositoryMock!
        var useCases: TeamsUseCases!
        
        beforeEach {
            webServiceMock = TeamsWebServiceMock()
            repositoryMock = TeamsRealmRepositoryMock()
            useCases = TeamsUseCasesImp(service: webServiceMock, repository: repositoryMock)
        }
        
        describe(".init") {
            it("should not call webService.getTeams") {
                expect(webServiceMock.getTeamsInvocations).to(equal(0))
            }
            
            it("should not call repository.get") {
                expect(repositoryMock.getInvocations).to(equal(0))
            }
            
            it("should not call repository.save") {
                expect(repositoryMock.saveInvocations).to(equal(0))
            }
        }
        
        describe(".getTeams") {
            let networkModel = TeamNetworkModel(
                name: "stub",
                abbreviatedName: "stub",
                logo: .init(main: .init(png: "stub")),
                location: "stub"
            )
            var successCompletionInvovation: Int!
            var failureCompletionInvovation: Int!
            var finishedCompletionInvovation: Int!
            
            var subscriptions = Set<AnyCancellable>()
            
            context("when a request has success and hasn't cache") {
                beforeEach {
                    webServiceMock.expectedResult = .success(teams: [networkModel])
                    repositoryMock.expectedResult = []
                    
                    successCompletionInvovation = 0
                    failureCompletionInvovation = 0
                    finishedCompletionInvovation = 0
                    
                    useCases.getTeams()
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure:
                                failureCompletionInvovation += 1
                            case .finished:
                                finishedCompletionInvovation += 1
                            }
                        }, receiveValue: { models in
                            successCompletionInvovation += 1
                        })
                        .store(in: &subscriptions)
                }
                
                it("should try to get cache before request") {
                    expect(repositoryMock.getInvocations).to(equal(1))
                }
                
                it("should request teams from web service") {
                    expect(webServiceMock.getTeamsInvocations).to(equal(1))
                }
                
                it("should save model after a request with success") {
                    expect(repositoryMock.saveInvocations).toEventually(equal(1))
                }
                
                it("should call completion with success") {
                    expect(successCompletionInvovation).toEventually(equal(1))
                }
                
                it("should not call completion with failure") {
                    expect(failureCompletionInvovation).toEventually(equal(0))
                }
                
                it("should call .finshed to end streaming") {
                    expect(finishedCompletionInvovation).toEventually(equal(1))
                }
            }
            
            context("when a request has success and has cache") {
                beforeEach {
                    webServiceMock.expectedResult = .success(teams: [networkModel])
                    repositoryMock.expectedResult = [networkModel.asDomain()]
                    
                    successCompletionInvovation = 0
                    failureCompletionInvovation = 0
                    finishedCompletionInvovation = 0
                    useCases.getTeams()
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure:
                                failureCompletionInvovation += 1
                            case .finished:
                                finishedCompletionInvovation += 1
                            }
                        }, receiveValue: { models in
                            successCompletionInvovation += 1
                        })
                        .store(in: &subscriptions)
                }
                
                it("should try to get cache before request") {
                    expect(repositoryMock.getInvocations).to(equal(1))
                }
                
                it("should request teams from web service") {
                    expect(webServiceMock.getTeamsInvocations).to(equal(1))
                }
                
                it("should save model after a request with success") {
                    expect(repositoryMock.saveInvocations).toEventually(equal(1))
                }
                
                it("should call completion with success twice") {
                    expect(successCompletionInvovation).toEventually(equal(2))
                }
                
                it("should not call completion with failure") {
                    expect(failureCompletionInvovation).toEventually(equal(0))
                }
                
                it("should call .finshed to end streaming") {
                    expect(finishedCompletionInvovation).toEventually((equal(1)))
                }
            }
            
            context("when a request has fail and hasn't cache") {
                beforeEach {
                    webServiceMock.expectedResult = .failure(error: .unkown)
                    repositoryMock.expectedResult = []
                    
                    successCompletionInvovation = 0
                    failureCompletionInvovation = 0
                    finishedCompletionInvovation = 0
                    
                    useCases.getTeams()
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure:
                                failureCompletionInvovation += 1
                            case .finished:
                                finishedCompletionInvovation += 1
                            }
                        }, receiveValue: { models in
                            successCompletionInvovation += 1
                        })
                        .store(in: &subscriptions)
                }
                
                it("should try to get cache before request") {
                    expect(repositoryMock.getInvocations).to(equal(1))
                }
                
                it("should request teams from web service") {
                    expect(webServiceMock.getTeamsInvocations).to(equal(1))
                }
                
                it("should not try to save a model after request failure") {
                    expect(repositoryMock.saveInvocations).to(equal(0))
                }
                
                it("should not call completion with success") {
                    expect(successCompletionInvovation).toEventually(equal(0))
                }
                
                it("should call completion with failure") {
                    expect(failureCompletionInvovation).toEventually(equal(1))
                }
                
                it("should call .finshed to end streaming") {
                    expect(finishedCompletionInvovation).toEventually(equal(0))
                }
            }
            
            context("when a request has fail and has cache") {
                beforeEach {
                    webServiceMock.expectedResult = .failure(error: .unkown)
                    repositoryMock.expectedResult = [networkModel.asDomain()]
                    
                    successCompletionInvovation = 0
                    failureCompletionInvovation = 0
                    finishedCompletionInvovation = 0
                    
                    useCases.getTeams()
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure:
                                failureCompletionInvovation += 1
                            case .finished:
                                finishedCompletionInvovation += 1
                            }
                        }, receiveValue: { models in
                            successCompletionInvovation += 1
                        })
                        .store(in: &subscriptions)
                }
                
                it("should try to get cache before request") {
                    expect(repositoryMock.getInvocations).to(equal(1))
                }
                
                it("should request teams from web service") {
                    expect(webServiceMock.getTeamsInvocations).to(equal(1))
                }
                
                it("should not try to save a model after request failure") {
                    expect(repositoryMock.saveInvocations).to(equal(0))
                }
                
                it("should call completion with success") {
                    expect(successCompletionInvovation).toEventually(equal(1))
                }
                
                it("should call completion with failure") {
                    expect(failureCompletionInvovation).toEventually(equal(1))
                }
                
                it("should call .finshed to end streaming") {
                    expect(finishedCompletionInvovation).toEventually(equal(0))
                }
            }
        }
    }
}
