import UIKit
import SnapKit

class BreedCell: UITableViewCell {
    let name = UILabel()
    let favoriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupName()
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupName() {
        contentView.addSubview(name)
        name.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
        }
    }

    private func setupButton() {
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.frame = .init(x: 0, y: 0, width: 50, height: 50)
        accessoryView = favoriteButton
    }
}
