import Foundation
import Combine

final class RequestExecuterImp {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
}

// MARK: - RequestExecuter

extension RequestExecuterImp: RequestExecuter {
    func execute(with urlRquest: URLRequest) -> AnyPublisher<Data, NetworkPlataformError> {
        urlSession
            .dataTaskPublisher(for: urlRquest)
            .tryMap { data, response in
                if let error = URLResponseErrorParser().parseErrorIfExists(on: response) {
                    throw error
                }
                
                return data
            }
            .mapError(NetworkPlataformErrorParser().parse)
            .eraseToAnyPublisher()
    }
}
