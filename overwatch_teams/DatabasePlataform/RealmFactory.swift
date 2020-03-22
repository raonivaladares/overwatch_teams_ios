import Foundation
import RealmSwift

final class RealmFactory {
    private let realmName = "overwatch.teams.realm"
    
    func createInstance() -> Realm {
        do {
            let url = try getUrl()
            
            let configuration = Realm.Configuration(
                fileURL: url,
                schemaVersion: 0
            )
            
            let realm = try Realm(configuration: configuration)
            
            return realm
            
        } catch {
            deleteRealm()
            return createInstance()
        }
    }
    
    private func getUrl() throws -> URL {
        let fileManager = FileManager()
        
        guard
            let directory = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true
            ).first else {
                throw DomainError.domainUnkown
        }

        if !fileManager.fileExists(atPath: directory) {
            try fileManager.createDirectory(
                atPath: directory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        return .init(fileURLWithPath: "\(directory)/\(realmName)")
    }
    
    private func deleteRealm() {
        do {
            try FileManager.default.removeItem(at: getUrl())
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
