import Foundation
import Combine

protocol TeamsWebService {
//    func getTeams(completion: @escaping (Result<[TeamNetworkModel], NetworkPlataformError>) -> Void)
    func getTeams() -> AnyPublisher<[TeamNetworkModel], NetworkPlataformError>
}

final class TeamsWebServiceImp {
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
    
//    func getTeams(completion: @escaping (Result<[TeamNetworkModel], NetworkPlataformError>) -> Void) {
//        
//        let urlRequest = URLRequestBuilder(
//            action: actions.createGetTeams(),
//            configuration: configuration
//        ).build()
//        
//        guard let request = urlRequest else {
//            completion(.failure(.unkown))
//            return
//        }
//        
//        requestExecuter.execute(with: request) { result in
//            switch result {
//            case .success(let data):
//                guard let teamsResponse = try? JSONDecoder().decode(TeamsResponse.self, from: data) else {
//                    completion(.failure(.unkown))
//                    return
//                }
//                
//                completion(.success(teamsResponse.data))
//            case .failure(let error):
//                print(error)
//                completion(.failure(.unkown))
//            }
//        }
//    }
}

extension TeamsWebServiceImp: TeamsWebService {
    func getTeams() -> AnyPublisher<[TeamNetworkModel], NetworkPlataformError> {
        let urlRequest = URLRequestBuilder(
            action: actions.createGetTeams(),
            configuration: configuration
        ).build()
        
        
        
        guard let request = urlRequest else {
            return Fail<[TeamNetworkModel], NetworkPlataformError>(error: .unkown)
            .eraseToAnyPublisher()
        }
        
         return requestExecuter.execute(with: request)
        .decode(type: TeamsResponse.self, decoder: JSONDecoder())
        .mapError { error in
            if let _ = error as? DecodingError {
                return .unkown
            }
            
            return error as? NetworkPlataformError ?? .unkown
         }
         .map { $0.data }
        .eraseToAnyPublisher()
    }
}
