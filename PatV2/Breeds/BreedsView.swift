import UIKit

class BreedsView: UIView {

    let tableView = UITableView()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
