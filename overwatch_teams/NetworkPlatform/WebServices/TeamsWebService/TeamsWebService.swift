import Combine

protocol TeamsWebService {
    func getTeams() -> AnyPublisher<[TeamNetworkModel], NetworkPlataformError>
}
