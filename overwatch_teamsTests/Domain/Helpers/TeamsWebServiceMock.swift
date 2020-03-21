@testable import overwatch_teams

final class TeamsWebServiceMock: TeamsWebService {
    enum ExpectedResult {
        case success(teams: [TeamNetworkModel])
        case failure(error: NetworkPlataformError)
    }
    
    var expectedResult: ExpectedResult?
    var getTeamsInvocations = 0
    
    func getTeams(completion: @escaping (Result<[TeamNetworkModel], NetworkPlataformError>) -> Void) {
        getTeamsInvocations += 1
        
        guard let expectedResult = expectedResult else { return }
        
        switch expectedResult {
        case .success(let teams):
            completion(.success(teams))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
