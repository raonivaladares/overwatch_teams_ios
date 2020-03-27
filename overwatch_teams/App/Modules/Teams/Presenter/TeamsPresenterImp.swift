import Foundation
import Combine

final class TeamsPresenterImp {
    private weak var viewController: TeamsViewController?
    private let router: TeamsRouter
    private let teamsUseCases: TeamsUseCases
    private var teamsModels: [TeamModel] = []
    
    var subscriptions = Set<AnyCancellable>()
    
    init(viewController: TeamsViewController, teamsUseCases: TeamsUseCases, router: TeamsRouter) {
        self.viewController = viewController
        self.teamsUseCases = teamsUseCases
        self.router = router
        
        let viewModel = TeamsViewModel(viewState: .loading)
        viewController.configure(with: viewModel)
        
        teamsUseCases.getTeams()
            .sink(receiveCompletion: receiveCompletionHandler, receiveValue: receiveValueHandler)
            .store(in: &subscriptions)
    }
}

// MARK: - TeamsPresenter

extension TeamsPresenterImp: TeamsPresenter  {
    func eventHandler(event: TeamsPresenterEvent) {
        switch event {
        case .elementSelected(let rowIndex):
            router.teamSelected(teamSelected: teamsModels[rowIndex])
        }
    }
}

extension TeamsPresenterImp  {
    private func receiveCompletionHandler(completion: Subscribers.Completion<DomainError>) {
        switch completion {
        case .failure:
            if self.teamsModels.isEmpty {
                let viewModel = TeamsViewModel(
                    viewState: .showError(errorMessage: "Sorry, something went wrong! =(")
                )
                viewController?.configure(with: viewModel)
            }
        case .finished:
            break
        }
    }
    
    private func receiveValueHandler(value: [TeamModel]) {
        teamsModels = value

        let cellsViewModels: [TeamCell.ViewModel] = teamsModels.map {
            .init(
                logoAddress: $0.logoAddress,
                name: $0.name,
                abbreviatedName: $0.abbreviatedName
            )
        }

        let viewModel = TeamsViewModel(
            viewState: .showContent(cellsViewModel: cellsViewModels)
        )

        DispatchQueue.main.async() {
            self.viewController?.configure(with: viewModel)
        }
    }
}
