import Foundation

protocol Repository {
    func save(domainModels: [TeamModel])
    func get() -> [TeamModel]
}
