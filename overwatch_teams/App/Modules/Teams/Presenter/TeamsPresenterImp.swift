import Foundation

final class TeamsPresenterImp {
    private weak var viewController: TeamsViewController?
    private let router: TeamsRouter
    private let teamsUseCases: TeamsUseCases
    private var teamsModels: [TeamModel] = []
    
    init(viewController: TeamsViewController, teamsUseCases: TeamsUseCases, router: TeamsRouter) {
        self.viewController = viewController
        self.teamsUseCases = teamsUseCases
        self.router = router
        
        let viewModel = TeamsViewModel(viewState: .loading)
        viewController.configure(with: viewModel)
       
        teamsUseCases.getTeams() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let teamsModels):
                    self.teamsModels = teamsModels

                    let cellsViewModels: [TeamCell.ViewModel] = teamsModels.map {  TeamCell.ViewModel(logoAddress: $0.logoAddress, name: $0.name, abbreviatedName: $0.abbreviatedName) }
                    let viewModel = TeamsViewModel(viewState: .showContent(cellsViewModel: cellsViewModels))
                    DispatchQueue.main.async() {
                        viewController.configure(with: viewModel)
                    }
            case .failure(let error):
                if self.teamsModels.isEmpty {
                    let viewModel = TeamsViewModel(viewState: .showError(errorMessage: "Sorry, something went wrong! =("))
                    viewController.configure(with: viewModel)
                }
            }
        }
    }
}

extension TeamsPresenterImp: TeamsPresenter  {
    func eventHandler(event: TeamsPresenterEvent) {
        switch event {
        case .elementSelected(let rowIndex):
            router.teamSelected(teamSelected: teamsModels[rowIndex])
        }
    }
}
