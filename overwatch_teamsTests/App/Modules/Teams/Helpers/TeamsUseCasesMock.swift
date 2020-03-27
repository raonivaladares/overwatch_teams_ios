import Foundation
import Combine

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
    func getTeams() -> AnyPublisher<[TeamModel], DomainError> {
        getTeamsInvocations += 1
        let passthroughSubject = PassthroughSubject<[TeamModel], DomainError>()
        
        guard let expectedResult = expectedResult else {
            passthroughSubject.send(completion: .finished)
            return passthroughSubject
                .eraseToAnyPublisher()
        }
        
        
        switch expectedResult {
        case .successWithoutCache:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { passthroughSubject.send([self.model]) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { passthroughSubject.send(completion: .finished) }
        case .successWithCache:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { passthroughSubject.send([self.model]) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { passthroughSubject.send([self.model]) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { passthroughSubject.send(completion: .finished) }
        case .failureWithoutCache:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { passthroughSubject.send(completion: .failure(.domainUnkown)) }
        case .failureWithCache:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { passthroughSubject.send([self.model]) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { passthroughSubject.send(completion: .failure(.domainUnkown)) }
        }
        
        
        return passthroughSubject
            .eraseToAnyPublisher()
    }
    
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
