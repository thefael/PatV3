import UIKit
import SnapKit

class DogsView: UIView {

    let tableView = UITableView()
    let alertView = UIAlertController()

    override init(frame: CGRect = Constants.screen) {
        super.init(frame: frame)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
}
