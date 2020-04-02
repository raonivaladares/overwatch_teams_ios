import Foundation
import Combine

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
