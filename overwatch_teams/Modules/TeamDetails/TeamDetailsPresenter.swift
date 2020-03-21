import Foundation

final class TeamDetailsPresenter {
    private weak var viewController: TeamDetailsViewController?
    
    init(viewController: TeamDetailsViewController, teamModel: TeamModel) {
        self.viewController = viewController
        
        let viewModel = TeamDetailsViewModel(
            logoAddress: teamModel.logoAddress,
            name: teamModel.name,
            abbreviatedName: teamModel.abbreviatedName,
            location: teamModel.location
        )
        
        viewController.configure(with: viewModel)
    }
}
