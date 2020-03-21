import UIKit

final class TeamDetailsViewControllerImp: UIViewController {
    private let teamDetailsView: TeamDetailsView
    
    init(teamDetailsView: TeamDetailsView) {
        self.teamDetailsView = teamDetailsView

        super.init(nibName: nil, bundle: nil)

        title = "Teams Details"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = teamDetailsView
    }
}

// MARK: - TeamDetailsViewController

extension TeamDetailsViewControllerImp: TeamDetailsViewController {
    func configure(with viewModel: TeamDetailsViewModel) {
        teamDetailsView.configure(with: viewModel)
    }
}
