import Foundation
import Combine

protocol RequestExecuter {
    func execute(with urlRquest: URLRequest) -> AnyPublisher<Data, NetworkPlataformError>
}
