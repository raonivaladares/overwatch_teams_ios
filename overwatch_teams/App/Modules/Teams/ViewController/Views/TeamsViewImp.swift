import UIKit
import SnapKit

class TeamsViewImp: UIView {
    private let activityIndication: UIActivityIndicatorView = {
        let activityIndication = UIActivityIndicatorView()
        activityIndication.color = AppColors.loader
        activityIndication.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        return activityIndication
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.labelText
        label.font = .systemFont(ofSize: 21)
        label.textAlignment = .center

        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 140
        
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = "teamsTableView"
        
        return tableView
    }()
    
    private var cellsViewModels: [TeamCell.ViewModel] = []
    
    var eventHandler: EventHandler?
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = AppColors.viewBackground
        
        addViews()
        defineAndActivateConstraints()
        registerTableViewElements()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TeamsView

extension TeamsViewImp: TeamsView {
    func configure(with viewModel: TeamsViewModel) {
        if viewModel.isLoading {
            activityIndication.startAnimating()
            errorMessageLabel.isHidden = true
            tableView.isHidden = true
        } else {
            activityIndication.stopAnimating()
        }
        
        if let errorMessage = viewModel.errorMessage {
            errorMessageLabel.text = errorMessage
            errorMessageLabel.isHidden = false
        }
        
        if let cellsViewModels = viewModel.cellsViewModels {
            self.cellsViewModels = cellsViewModels
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
}


// MARK: - Private methods - UI

extension TeamsViewImp {
    private func addViews() {
        addSubview(activityIndication)
        addSubview(errorMessageLabel)
        addSubview(tableView)
    }
    
    private func defineAndActivateConstraints() {
        activityIndication.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        errorMessageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func registerTableViewElements() {
        tableView.register(
            TeamCell.self,
            forCellReuseIdentifier: TeamCell.reuseIdentifier
        )
    }
}

// MARK: - UITableViewDataSource

extension TeamsViewImp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TeamCell.reuseIdentifier,
            for: indexPath
        ) as! TeamCell

        let viewModel = cellsViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TeamsViewImp: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        eventHandler?(.elementSelected(rowIndex: indexPath.row))
    }
}
