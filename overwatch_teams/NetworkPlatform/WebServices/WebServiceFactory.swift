import Foundation

final class WebServiceFactory {
    func createTeamsWebService() -> TeamsWebService {
        let configuration = OverwatchLeagueWebServiceConfiguration()
        let requestExecuter = RequestExecuterImp(urlSession: URLSession.shared)
        
        return TeamsWebServiceImp(
            actions: TeamsServiceActionsFactoryImp(),
            configuration: configuration,
            requestExecuter: requestExecuter
        )
    }
}
