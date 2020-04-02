extension WebServiceActions {
    struct GetTeams: WebServiceAction {
        let path = "/v2/teams"
        let method: HTTPMethod = .get
    }
}
