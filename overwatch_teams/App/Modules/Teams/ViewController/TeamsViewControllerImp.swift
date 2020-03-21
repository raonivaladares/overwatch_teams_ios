import UIKit

final class TeamsViewControllerImp: UIViewController {
    private let teamsView: TeamsView
    var presenter: TeamsPresenter?
    
    init(teamsView: TeamsView) {
        self.teamsView = teamsView
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Overwatch Teams"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamsView.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .elementSelected(let index):
                self.presenter?.eventHandler(event: .elementSelected(rowIndex: index))
            }
        }
    }
    
    override func loadView() {
        view = teamsView
    }
}

// MARK: - TeamsViewController

extension TeamsViewControllerImp: TeamsViewController {
    func configure(with viewModel: TeamsViewModel) {
        teamsView.configure(with: viewModel)
    }
}
