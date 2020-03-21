struct TeamsViewModel {
    let isLoading: Bool
    let errorMessage: String?
    let cellsViewModels: [TeamCell.ViewModel]?
}

extension TeamsViewModel {
    enum State {
        case loading
        case showError(errorMessage: String)
        case showContent(cellsViewModel: [TeamCell.ViewModel])
    }
    
    init(viewState: State) {
        switch viewState {
        case .loading:
            isLoading = true
            errorMessage = nil
            cellsViewModels = nil
        case .showError(let errorMessage):
            isLoading = false
            self.errorMessage = errorMessage
            cellsViewModels = nil
        case .showContent(let cellsViewModel):
            isLoading = false
            errorMessage = nil
            self.cellsViewModels = cellsViewModel
        }
    }
}
