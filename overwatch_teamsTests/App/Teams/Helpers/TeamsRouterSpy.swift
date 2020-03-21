@testable import overwatch_teams

final class TeamsRouterSpy {
    var teamSelectedInvocations = 0
}

extension TeamsRouterSpy: TeamsRouter {
    func teamSelected(teamSelected: TeamModel) {
        teamSelectedInvocations += 1
    }
}
