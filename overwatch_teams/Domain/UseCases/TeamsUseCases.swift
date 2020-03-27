import Foundation
import Combine

protocol TeamsUseCases {
    func getTeams() -> AnyPublisher<[TeamModel], DomainError>
}

final class TeamsUseCasesImp {
    private let service: TeamsWebService
    private let repository: Repository
    
    init(service: TeamsWebService, repository: Repository) {
        self.service = service
        self.repository = repository
    }
}

// MARK: - TeamsUseCases

extension TeamsUseCasesImp: TeamsUseCases {
    func getTeams() -> AnyPublisher<[TeamModel], DomainError> {
        let future = Future<[TeamModel], DomainError> { [weak self] promise in
            self?.service.getTeams() { [weak self] result in
                guard let self = self else {
                    promise(.failure(.domainUnkown))
                    return
                }

                switch result {
                case .success(let teamsNetworkModel):
                    let models = teamsNetworkModel.map { $0.asDomain() }
                    self.repository.save(domainModels: models)
                    promise(.success(models))
                case .failure:
                    promise(.failure(.domainUnkown))
                }
            }
        }
        
        let localModels = repository.get()
        
        if !localModels.isEmpty {
            return future
                .prepend(localModels)
                .eraseToAnyPublisher()
        }
        
        return future
            .eraseToAnyPublisher()
    }
}
