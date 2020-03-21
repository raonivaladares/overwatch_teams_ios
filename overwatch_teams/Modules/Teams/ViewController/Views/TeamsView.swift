import UIKit

protocol TeamsView: UIView {
    typealias EventHandler = (TeamsViewEvent) -> Void
    var eventHandler: EventHandler? { get set }
    func configure(with viewModel: TeamsViewModel)
}
