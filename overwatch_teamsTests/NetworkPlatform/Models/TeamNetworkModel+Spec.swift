import Quick
import Nimble

@testable import overwatch_teams

final class TeamNetworkModelSpec: QuickSpec {
    override func spec() {
        describe(".asDomain") {
            let modelNetwork = TeamNetworkModel(
                name: "name stub",
                abbreviatedName: "abbreviatedName stub",
                logo: .init(main: .init(png: "logo stub")),
                location: "location stub"
            )
            let model = modelNetwork.asDomain()
            
            it("sets model.name equal to modelNetwork.name") {
                expect(model.name).to(equal(modelNetwork.name))
            }
            
            it("sets model.abbreviatedName equal to modelNetwork.abbreviatedName") {
                expect(model.abbreviatedName).to(equal(modelNetwork.abbreviatedName))
            }
            
            it("sets model.logoAddress equal to modelNetwork.logo.main.png") {
                expect(model.logoAddress).to(equal(modelNetwork.logo.main.png))
            }
            
            it("sets model.location equal to modelNetwork.location") {
                expect(model.location).to(equal(modelNetwork.location))
            }
        }
    }
}
