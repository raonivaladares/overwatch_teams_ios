@testable import overwatch_teams

final class TeamsUseCasesMock {
    enum ExpectedResult {
        case successWithoutCache
        case successWithCache
        case failureWithoutCache
        case failureWithCache
    }
    
    private let model = TeamModel(
        logoAddress: "stub",
        name: "stub",
        abbreviatedName: "stub",
        location: "stub"
    )
    
    var expectedResult: ExpectedResult?
    var getTeamsInvocations = 0
}

extension TeamsUseCasesMock: TeamsUseCases {
    func getTeams(completion: @escaping (Result<[TeamModel], DomainError>) -> Void) {
        getTeamsInvocations += 1
        
        guard let expectedResult = expectedResult else { return }
        
        switch expectedResult {
        case .successWithoutCache:
            completion(.success([model]))
        case .successWithCache:
            completion(.success([model]))
            completion(.success([model]))
        case .failureWithoutCache:
            completion(.failure(.domainUnkown))
        case .failureWithCache:
            completion(.success([]))
            completion(.failure(.domainUnkown))
        }
    }
}
