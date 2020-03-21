@testable import overwatch_teams

final class TeamsRealmRepositoryMock: Repository {
    var expectedResult: [TeamModel] = []
    var saveInvocations = 0
    var getInvocations = 0
    
    func save(domainModels: [TeamModel]) {
        saveInvocations += 1
    }
    
    func get() -> [TeamModel] {
        getInvocations += 1
        
        return expectedResult
    }
}
