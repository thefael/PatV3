import UIKit
import SnapKit

protocol FavoriteButtonDelegate: class {
    func toggleFavorite(breed: String) -> FavoriteState
}

class BreedCell: UITableViewCell {
    let nameLabel = UILabel()
    var name = String()
    let favoriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var delegate: FavoriteButtonDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupName()
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupName() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
        }
    }

    private func setupButton() {
        favoriteButton.addTarget(self, action: #selector(toggleButtonImage), for: .touchUpInside)
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.frame = .init(x: 0, y: 0, width: 50, height: 50)
        accessoryView = favoriteButton
    }

    @objc func toggleButtonImage() {
        guard let delegate = delegate else { return }

        switch delegate.toggleFavorite(breed: name) {
        case .isFavorite:
            favoriteButton.setImage(.heartFill, for: .normal)
        case .isNotFavorite:
            favoriteButton.setImage(.heart, for: .normal)
        }
    }
}
