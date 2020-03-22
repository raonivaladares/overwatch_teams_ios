import Quick
import Nimble

@testable import overwatch_teams

final class TeamRealmEntitySpec: QuickSpec {
    override func spec() {
        describe(".init(teamModel: )") {
            let model = TeamModel(
                logoAddress: "logo stub",
                name: "name stub",
                abbreviatedName: "abbreviatedName stub",
                location: "location stub"
            )
            
            let entity = TeamRealmEntity(teamModel: model)
            
            it("sets entity.id equal to model: name-abbreviatedName") {
                expect(entity.id).to(equal(("\(model.name)-\(model.abbreviatedName)")))
            }
            
            it("sets entity.logoAddress equal to model.logo.main.png") {
                expect(entity.logoAddress).to(equal(model.logoAddress))
            }
            
            it("sets entity.name equal to model.name") {
                expect(entity.name).to(equal(model.name))
            }
            
            it("sets entity.abbreviatedName equal to model.abbreviatedName") {
                expect(entity.abbreviatedName).to(equal(model.abbreviatedName))
            }
            
            it("sets entity.location equal to model.location") {
                expect(entity.location).to(equal(model.location))
            }
            
        }
        
        describe(".asDomain") {
            let entity = TeamRealmEntity()
            entity.logoAddress = "logo stub"
            entity.name = "name stub"
            entity.abbreviatedName = "abbreviatedName stub"
            entity.location = "location stub"
            
            let model = entity.asDomain()
            
            it("sets model.logoAddress equal to entity.logo.main.png") {
                expect(model.logoAddress).to(equal(entity.logoAddress))
            }
            
            it("sets model.name equal to entity.name") {
                expect(model.name).to(equal(entity.name))
            }
            
            it("sets model.abbreviatedName equal to entity.abbreviatedName") {
                expect(model.abbreviatedName).to(equal(entity.abbreviatedName))
            }
            
            it("sets model.location equal to entity.location") {
                expect(model.location).to(equal(entity.location))
            }
        }
    }
}
