import Foundation
import Combine

@testable import overwatch_teams

final class TeamsWebServiceMock {
    enum ExpectedResult {
        case success(teams: [TeamNetworkModel])
        case failure(error: NetworkPlataformError)
    }
    
    var expectedResult: ExpectedResult?
    var getTeamsInvocations = 0
}

extension TeamsWebServiceMock: TeamsWebService {
   func getTeams() -> AnyPublisher<[TeamNetworkModel], NetworkPlataformError> {
        getTeamsInvocations += 1
        
        let passthroughSubject = PassthroughSubject<[TeamNetworkModel], NetworkPlataformError>()
        
        guard let expectedResult = expectedResult else {
            passthroughSubject.send(completion: .finished)
            
            return passthroughSubject
                .eraseToAnyPublisher()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            switch expectedResult {
            case .success(let teams):
                passthroughSubject.send(teams)
                passthroughSubject.send(completion: .finished)
            case .failure(let error):
                passthroughSubject.send(completion: .failure(error))
            }
        }
    
        return passthroughSubject
            .eraseToAnyPublisher()
    }
}
