import UIKit

final class TeamsRouterImp: TeamsRouter {
    private let navigationController: UINavigationController
    
    init(currentNavigation: UINavigationController) {
        navigationController = currentNavigation
    }
    
    func teamSelected(teamSelected: TeamModel) {
        let viewController = TeamDetailsModuleAssembler().assemble(teamModel: teamSelected)
        navigationController.pushViewController(viewController, animated: true)
    }
}
