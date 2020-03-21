import UIKit

@testable import overwatch_teams

final class TeamsViewControllerSpy: UIViewController {
    var configureInvocations = 0
}

extension TeamsViewControllerSpy: TeamsViewController {
    func configure(with viewModel: TeamsViewModel) {
        configureInvocations += 1
    }
}
