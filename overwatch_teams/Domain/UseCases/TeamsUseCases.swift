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
        var publisher: AnyPublisher<[TeamModel], DomainError>  = service.getTeams()
            .map { [weak self] networkModels in
                let models = networkModels.map { $0.asDomain() }
                self?.repository.save(domainModels: models)
                
                return models
            }
            .mapError { _ in .domainUnkown }
            .eraseToAnyPublisher()
        
        
        let localModels = repository.get()
        
        if !localModels.isEmpty {
            publisher = publisher
                .prepend(localModels)
                .eraseToAnyPublisher()
        }
        
        return publisher
    }
}
