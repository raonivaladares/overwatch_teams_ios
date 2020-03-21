import UIKit

@testable import overwatch_teams

final class TeamDetailsViewControllerSpy: UIViewController {
    var configureInvocations = 0
}

extension TeamDetailsViewControllerSpy: TeamDetailsViewController {
    func configure(with viewModel: TeamDetailsViewModel) {
        configureInvocations += 1
    }
}
