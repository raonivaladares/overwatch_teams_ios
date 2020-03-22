import UIKit

final class TeamCell: UITableViewCell {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = AppColors.imagePlaceHolder
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = AppColors.labelText
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    private let abbreviatedNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.labelText
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = AppColors.cellBackground
        
        addViewProperties()
        defineAndActivateConstraints()
        
        isAccessibilityElement = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        logoImageView.image = nil
        nameLabel.text = nil
        abbreviatedNameLabel.text = nil
    }
}

// MARK: - Public methods - UI

extension TeamCell {
    func configure(with viewModel: ViewModel) {
        nameLabel.text = viewModel.name
        abbreviatedNameLabel.text = viewModel.abbreviatedName
        logoImageView.downloaded(from: viewModel.logoAddress, contentMode: .scaleAspectFit)
        
        accessibilityIdentifier = "teamCell\(viewModel.abbreviatedName)"
    }
}

// MARK: - Private methods - UI

extension TeamCell {
    private func addViewProperties() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(abbreviatedNameLabel)
    }
    
    private func defineAndActivateConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.width.equalTo(90)
            $0.height.equalTo(110)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.centerY.equalTo(logoImageView.snp.centerY)
        }
    }
}

// MARK: - ReusableIdentifier

extension TeamCell: ReusableIdentifier {}
