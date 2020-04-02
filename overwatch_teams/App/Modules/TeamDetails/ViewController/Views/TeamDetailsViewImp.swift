import UIKit

final class TeamDetailsViewImp: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let logoImageView: UIImageView = {
        let coverImageView = UIImageView()
        coverImageView.backgroundColor = AppColors.Components.imagePlaceHolder
        coverImageView.contentMode = .scaleAspectFit

        return coverImageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.Components.labelText
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    private let abbreviatedNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.Components.labelText
        label.font = .systemFont(ofSize: 21)
        label.textAlignment = .center

        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.Components.labelText
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center

        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = AppColors.Components.viewBackground
        
        addViews()
        defineAndActivateConstraints()
    }
}

// MARK: - TeamDetailsView

extension TeamDetailsViewImp: TeamDetailsView {
    func configure(with viewModel: TeamDetailsViewModel) {
        logoImageView.downloaded(from: viewModel.logoAddress, contentMode: .scaleAspectFit)
        nameLabel.text = viewModel.name
        abbreviatedNameLabel.text = viewModel.abbreviatedName
        locationLabel.text = viewModel.location
    }
}

// MARK: - Private methods - UI

extension TeamDetailsViewImp {
    func addViews() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(abbreviatedNameLabel)
        contentView.addSubview(locationLabel)
    }
    
    func defineAndActivateConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(.low)
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }

        let marginSpace = 20
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(marginSpace)
            $0.leading.equalToSuperview().offset(marginSpace)
            $0.trailing.equalToSuperview().offset(-marginSpace)
        }

        abbreviatedNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(marginSpace)
            $0.trailing.equalToSuperview().offset(-marginSpace)
        }

        locationLabel.snp.makeConstraints {
            $0.top.equalTo(abbreviatedNameLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(marginSpace)
            $0.trailing.equalToSuperview().offset(-marginSpace)
            $0.bottom.lessThanOrEqualToSuperview().offset(-marginSpace)
        }
    }
}
