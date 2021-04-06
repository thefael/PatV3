import UIKit
import SnapKit

class DogCell: UITableViewCell {
    var dogImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDogImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupDogImage() {
        dogImageView.clipsToBounds = true
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dogImageView)
        dogImageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        dogImageView.contentMode = .scaleAspectFill
    }
}
