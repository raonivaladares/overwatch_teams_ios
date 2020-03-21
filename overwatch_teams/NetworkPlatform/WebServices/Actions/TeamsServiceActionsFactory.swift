protocol TeamsServiceActionsFactory {
    func createGetTeams() -> WebServiceAction
}

final class TeamsServiceActionsFactoryImp: TeamsServiceActionsFactory {
    func createGetTeams() -> WebServiceAction {
        return GetTeams()
    }
}

extension TeamsServiceActionsFactoryImp {
    struct GetTeams: WebServiceAction {
        let path = "/v2/teams"
        let method: HTTPMethod = .get
    }
}
