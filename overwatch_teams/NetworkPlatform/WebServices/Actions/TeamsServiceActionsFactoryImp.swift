final class TeamsServiceActionsFactoryImp: TeamsServiceActionsFactory {
    func createGetTeams() -> WebServiceAction {
        return WebServiceActions.GetTeams()
    }
}
