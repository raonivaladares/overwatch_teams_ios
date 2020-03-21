import Foundation
import RealmSwift

final class TeamsRealmRepository: Repository {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func save(domainModels: [TeamModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            try? self.realm.write {
                let entities = domainModels.map { TeamRealmEntity(teamModel: $0) }
                self.realm.add(entities, update: .all)
            }
        }
    }
    
    func get() -> [TeamModel] {
        realm.objects(TeamRealmEntity.self).map { $0.asDomain() }
    }
}
