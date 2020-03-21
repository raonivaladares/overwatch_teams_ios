import UIKit

protocol ReusableIdentifier: UITableViewCell {}

extension ReusableIdentifier {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
