import Foundation

protocol TeamsWebService {
    func getTeams(completion: @escaping (Result<[TeamNetworkModel], NetworkPlataformError>) -> Void)
}

final class TeamsWebServiceImp: TeamsWebService {
    private let actions: TeamsServiceActionsFactory
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(actions: TeamsServiceActionsFactory,
         configuration: WebServiceConfiguration,
         requestExecuter: RequestExecuter) {
        
        self.actions = actions
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func getTeams(completion: @escaping (Result<[TeamNetworkModel], NetworkPlataformError>) -> Void) {
        
        let urlRequest = URLRequestBuilder(
            action: actions.createGetTeams(),
            configuration: configuration
        ).build()
        
        guard let request = urlRequest else {
            completion(.failure(.unkown))
            return
        }
        
        requestExecuter.execute(with: request) { result in
            switch result {
            case .success(let data):
                guard let teamsResponse = try? JSONDecoder().decode(TeamsResponse.self, from: data) else {
                    completion(.failure(.unkown))
                    return
                }
                
                completion(.success(teamsResponse.data))
            case .failure(let error):
                print(error)
                completion(.failure(.unkown))
            }
        }
    }
}
