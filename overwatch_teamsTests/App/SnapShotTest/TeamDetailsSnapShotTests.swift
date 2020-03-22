import XCTest
import SnapshotTesting

@testable import overwatch_teams

class TeamDetailsSnapShotTests: XCTestCase {

    override func setUp() {
        
        let image = UIImage(named: "fakeDalasLogo")!
        UIImageView.imageCache.setObject(image, forKey: "fake.png" as NSString)
    }

    override func tearDown() {}
    
    func testTeamDetailsViewController() {
        let view = TeamDetailsViewImp()
        let viewController = TeamDetailsViewControllerImp(teamDetailsView: view)
        let viewModel = TeamDetailsViewModel(
            logoAddress: "fake.png",
            name: "Dallas Fuel Stub",
            abbreviatedName: "DAL",
            location: "Dallas, TX"
        )
        
        viewController.configure(with: viewModel)
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneXsMax(.landscape)))
        
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11))
        assertSnapshot(matching: viewController, as: .image(on: .iPadPro11(.landscape)))
    }
}
