import UIKit

@testable import overwatch_teams

final class TeamDetailsViewSpy: UIView {
    var configureInvocations = 0
}

extension TeamDetailsViewSpy: TeamDetailsView {
    func configure(with viewModel: TeamDetailsViewModel) {
        configureInvocations += 1
    }
}
