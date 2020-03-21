import Quick
import Nimble

@testable import overwatch_teams

final class TeamsViewModelSpec: QuickSpec {
    override func spec() {
        describe(".init(viewState: )") {
            context("whent state is .loading") {
                let viewModel = TeamsViewModel(viewState: .loading)
                
                it("sets .loading to be true") {
                    expect(viewModel.isLoading).to(beTrue())
                }
                
                it("sets .errorMessage to be nil") {
                    expect(viewModel.errorMessage).to(beNil())
                }
                
                it("sets .cellsViewModels to be nil") {
                    expect(viewModel.cellsViewModels).to(beNil())
                }
            }
            
            context("whent state is .showError") {
                let errorMessage = "Hello Error!"
                let viewModel = TeamsViewModel(viewState: .showError(errorMessage: errorMessage))
                
                it("sets .loading to be false") {
                    expect(viewModel.isLoading).to(beFalse())
                }
                
                it("sets .errorMessage to have a value") {
                    expect(viewModel.errorMessage).to(equal(errorMessage))
                }
                
                it("sets .cellsViewModels to be nil") {
                    expect(viewModel.cellsViewModels).to(beNil())
                }
            }
            
            context("whent state is .showError") {
                let viewModel = TeamsViewModel(viewState: .showContent(cellsViewModel: []))
                
                it("sets .loading to be false") {
                    expect(viewModel.isLoading).to(beFalse())
                }
                
                it("sets .errorMessage to be nil") {
                    expect(viewModel.errorMessage).to(beNil())
                }
                
                it("sets .cellsViewModels to have a value") {
                    expect(viewModel.cellsViewModels).toNot(beNil())
                }
            }
        }
    }
}
