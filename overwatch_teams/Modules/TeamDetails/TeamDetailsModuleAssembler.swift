import UIKit

final class TeamDetailsModuleAssembler {
    func assemble(teamModel: TeamModel) -> UIViewController {
        let view = TeamDetailsViewImp()
        let viewController = TeamDetailsViewControllerImp(teamDetailsView: view)
        
        _ = TeamDetailsPresenter(
            viewController: viewController,
            teamModel: teamModel
        )
        
        return viewController
    }
}

