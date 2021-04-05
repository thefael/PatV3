import UIKit
import SnapKit

class DogCell: UITableViewCell {
    var dogImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDogImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDogImage() {
        contentView.addSubview(dogImage)
        dogImage.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
}
