import Foundation
import RealmSwift

class TeamRealmEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var logoAddress = ""
    @objc dynamic var name = ""
    @objc dynamic var abbreviatedName = ""
    @objc dynamic var location = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension TeamRealmEntity {
    func asDomain() -> TeamModel {
        .init(
            logoAddress: logoAddress,
            name: name,
            abbreviatedName: abbreviatedName,
            location: location
        )
    }

    convenience init(teamModel: TeamModel) {
        self.init()
        logoAddress = teamModel.logoAddress
        name = teamModel.name
        abbreviatedName = teamModel.abbreviatedName
        location = teamModel.location
        id =  "\(name)-\(abbreviatedName)"
    }
}

