import Foundation

struct TeamNetworkModel: Decodable {
    let name: String
    let abbreviatedName: String
    let logo: TeamLogoNetworkModel
    let location: String
}

extension TeamNetworkModel {
    func asDomain() -> TeamModel {
        .init(
            logoAddress: logo.main.png,
            name: name,
            abbreviatedName: abbreviatedName,
            location: location
        )
    }
}
