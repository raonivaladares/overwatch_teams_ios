import Quick
import Nimble
import Foundation

@testable import overwatch_teams

class URLRequestBuilderSpec: QuickSpec {
    override func spec() {
        let urlRquest = URLRequestBuilder(
            action: TeamsServiceActionsFactoryImp().createGetTeams(),
            configuration: OverwatchLeagueWebServiceConfiguration()
        ).build()
        
        describe(".build") {
            context("when action is getTeams and configuration is OverwatchLeague") {
                it("sets url address to expectedURLString") {
                    let expectedURLString = "https://api.overwatchleague.com/v2/teams"
                    
                    expect(urlRquest!.url!.relativeString).to(equal(expectedURLString))
                }
                
                it("it sets action to GET") {
                    let expectedHTTPMethod = "GET"
                    
                    expect(urlRquest!.httpMethod!).to(equal(expectedHTTPMethod))
                }
            }
        }
    }
}
