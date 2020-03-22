import Quick
import Nimble
import Foundation

@testable import overwatch_teams

class HTTPMethodSpec: QuickSpec {
    override func spec() {
        describe(".get") {
            it("sets url address to expectedURLString") {
                let expectedValue = "GET"
                
                expect(HTTPMethod.get.rawValue).to(equal(expectedValue))
            }
        }
    }
}
