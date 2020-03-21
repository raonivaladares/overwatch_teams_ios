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
                print("success")
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

//         return requestExecuter.execute(with: request)
//        .decode(type: StandingsResponse.self, decoder: JSONDecoder())
//        .mapError { error in
//            if let _ = error as? DecodingError {
//                return .unkown
//            }
//
//            return error as? NetworkPlataformError ?? .unkown
//         }

//            return requestExecuter.execute(with: request)
//                .tryMap { try JSONDecoder().decode(StandingsResponse.self, from: $0) }
//                .mapError { _ in .unkown }
//                .eraseToAnyPublisher()

struct TeamsResponse: Decodable {
    let data: [TeamNetworkModel]
}

struct TeamNetworkModel: Decodable {
    let name: String
    let abbreviatedName: String
    let logo: TeamLogoNetworkModel
    let location: String
}

struct TeamLogoNetworkModel: Decodable {
    let main: Main
}

struct Main: Decodable {
    let png: String
}



extension TeamNetworkModel {
    func asDomain() -> TeamModel {
        .init(
            logoAddress: logo.main.png,
            name: name,
            abbreviatedName: abbreviatedName,
            location: location
        )
    }
}
