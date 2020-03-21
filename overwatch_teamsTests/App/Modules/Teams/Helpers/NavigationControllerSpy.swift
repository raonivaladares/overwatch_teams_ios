import UIKit

@testable import overwatch_teams

final class NavigationControllerSpy: UINavigationController {
    var pushViewControllerInvocations = 0
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerInvocations += 1
    }
}
