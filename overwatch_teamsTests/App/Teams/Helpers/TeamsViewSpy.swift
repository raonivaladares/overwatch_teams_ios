import UIKit

@testable import overwatch_teams

final class TeamsViewSpy: UIView {
    var configureInvocations = 0
    var eventHandler: EventHandler?
}

extension TeamsViewSpy: TeamsView {
    func configure(with viewModel: TeamsViewModel) {
        configureInvocations += 1
    }
}
