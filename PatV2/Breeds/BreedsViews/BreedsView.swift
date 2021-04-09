import UIKit
import SnapKit

class BreedsView: UIView {

    let tableView = UITableView()

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
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(Constants.screen.width)
        }
    }
}
