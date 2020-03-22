import XCTest
import SnapshotTesting

@testable import overwatch_teams

class TeamsSnapShotTests: XCTestCase {

    override func setUp() {
        
        let image = UIImage(named: "fakeDalasLogo")!
        UIImageView.imageCache.setObject(image, forKey: "fake.png" as NSString)
        UIView.setAnimationsEnabled(false)
    }
    
    func testTeamDetailsStateLoading() {
        let view = TeamsViewImp()
        let viewController = TeamsViewControllerImp(teamsView: view)
        let viewModel = TeamsViewModel(viewState: .loading)
        
        viewController.configure(with: viewModel)
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11))
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11(.landscape)))
    }
    
    func testTeamDetailsStateShowError() {
        let view = TeamsViewImp()
        let viewController = TeamsViewControllerImp(teamsView: view)
        let viewModel = TeamsViewModel(
            viewState: .showError(errorMessage: "Sorry, we have a fake error!")
        )
       
        viewController.configure(with: viewModel)
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11))
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11(.landscape)))
    }
    
    func testTeamDetailsStateShowContent() {
        let view = TeamsViewImp()
        let viewController = TeamsViewControllerImp(teamsView: view)
        let viewModel = TeamsViewModel(
            viewState: .showContent(cellsViewModel: createStubCellsViewModels())
        )
        
        viewController.configure(with: viewModel)
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11))
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11(.landscape)))
    }
    
    private func createStubCellsViewModels() -> [TeamCell.ViewModel] {
        [
            .init(logoAddress: "fake.png", name: "Dallas Fuel Stub", abbreviatedName: "DAL"),
            .init(logoAddress: "fake.png", name: "Philadelphia Fusion Stub", abbreviatedName: "PHI"),
            .init(logoAddress: "fake.png", name: "Boston Uprising Stub", abbreviatedName: "BOS"),
            .init(logoAddress: "fake.png", name: "New York Excelsior Stub", abbreviatedName: "NYE"),
            .init(logoAddress: "fake.png", name: "San Francisco Shock Stub", abbreviatedName: "SFS"),
            .init(logoAddress: "fake.png", name: "Los Angeles Valiant Stub", abbreviatedName: "VAL"),
            .init(logoAddress: "fake.png", name: "Los Angeles Gladiators Stub", abbreviatedName: "GLA"),
            .init(logoAddress: "fake.png", name: "Florida Mayhem Stub", abbreviatedName: "FLA"),
        ]
    }
}

