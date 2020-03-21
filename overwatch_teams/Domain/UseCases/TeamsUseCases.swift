import Foundation

protocol TeamsUseCases {
    func getTeams(completion: @escaping (Result<[TeamModel], DomainError>) -> Void)
}

final class TeamsUseCasesImp: TeamsUseCases {
    private let service: TeamsWebService
    private let repository: Repository
    
    init(service: TeamsWebService, repository: Repository) {
        self.service = service
        self.repository = repository
    }
    
    func getTeams(completion: @escaping (Result<[TeamModel], DomainError>) -> Void) {
        let localModels = repository.get()
        
        if !localModels.isEmpty {
            completion(.success(localModels))
        }
        
        service.getTeams() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let teamsNetworkModel):
                let models = teamsNetworkModel.map { $0.asDomain() }
                self.repository.save(domainModels: models)
                completion(.success(models))
                
            case .failure(let error):
                print(error)
                completion(.failure(.domainUnkown))
            }
        }
    }
}
